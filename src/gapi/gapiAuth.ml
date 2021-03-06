type oauth1_data = {
  signature_method : GapiCore.SignatureMethod.t;
  consumer_key : string;
  consumer_secret : string;
  token : string;
  secret : string;
}

type oauth1_params = {
  http_method : GapiCore.HttpMethod.t;
  url : string;
  post_fields_to_sign : (string * string) list;
}

type oauth2_data = {
  client_id : string;
  client_secret : string;
  oauth2_token : string;
  refresh_token : string;
  refresh_access_token : (unit -> string) option;
}

type oauth2_service_account_data = {
  service_account_credentials_json : string;
  scopes : string list;
  user_to_impersonate : string option;
  oauth2_service_account_token : string;
  refresh_service_account_access_token : (unit -> string) option;
}

type authentication =
  | NoAuth
  | ClientLogin of string
  | OAuth1 of oauth1_data
  | OAuth2 of oauth2_data
  | OAuth2ServiceAccount of oauth2_service_account_data


let generate_authorization_header
    ?oauth1_params
    auth_data =
  match auth_data with
  | NoAuth ->
    None
  | ClientLogin auth ->
    Some ("GoogleLogin auth=" ^ auth)
  | OAuth1 { signature_method;
             consumer_key;
             consumer_secret;
             token;
             secret } ->
    let params = Option.get oauth1_params in
    let oauth_fields_to_sign = GapiOAuth1.build_oauth_fields_to_sign
        ~oauth_token:token
        consumer_key
        signature_method in
    let neturl = Neturl.parse_url params.url in
    let get_fields_to_sign =
      try
        Netencoding.Url.dest_url_encoded_parameters
          (Neturl.url_query ~encoded:true neturl)
      with Not_found -> [] in
    let base_neturl = Neturl.remove_from_url ~query:true neturl in
    let base_url = Neturl.string_of_url base_neturl in
    let signature = GapiOAuth1.generate_signature
        params.http_method
        base_url
        (oauth_fields_to_sign
         @ get_fields_to_sign
         @ params.post_fields_to_sign)
        signature_method
        consumer_secret
        secret
    in
    Some (GapiOAuth1.generate_oauth_header
            oauth_fields_to_sign
            signature)
  | OAuth2 { oauth2_token = token; _ }
  | OAuth2ServiceAccount { oauth2_service_account_token = token; _ } ->
    Some ("Bearer " ^ token)

