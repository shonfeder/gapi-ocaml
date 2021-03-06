(* Warning! This file is generated. Modify at your own risk. *)

(** Service definition for Google OAuth2 API (v2).
  
  Obtains end-user authorization grants for use with other Google APIs..
  
  For more information about this service, see the
  {{:https://developers.google.com/accounts/docs/OAuth2}API Documentation}.
  *)

module Scope :
sig
  val plus_login : string
  (** Know the list of people in your circles, your age range, and language *)
  
  val plus_me : string
  (** Know who you are on Google *)
  
  val userinfo_email : string
  (** View your email address *)
  
  val userinfo_profile : string
  (** View your basic profile info *)
  
  
end
(** Service Auth Scopes *)

module UserinfoResource :
sig
  module V2 :
  sig
    module Me :
    sig
      
      (** 
        
        @param base_url Service endpoint base URL (defaults to ["https://www.googleapis.com/"]).
        @param etag Optional ETag.
        @param std_params Optional standard parameters.
        *)
      val get :
        ?base_url:string ->
        ?etag:string ->
        ?std_params:GapiService.StandardParameters.t ->
        GapiConversation.Session.t ->
        GapiOauth2V2Model.Userinfoplus.t * GapiConversation.Session.t
      
      
    end
    
    
    
  end
  
  
  (** 
    
    @param base_url Service endpoint base URL (defaults to ["https://www.googleapis.com/"]).
    @param etag Optional ETag.
    @param std_params Optional standard parameters.
    *)
  val get :
    ?base_url:string ->
    ?etag:string ->
    ?std_params:GapiService.StandardParameters.t ->
    GapiConversation.Session.t ->
    GapiOauth2V2Model.Userinfoplus.t * GapiConversation.Session.t
  
  
end


(** 
  
  @param base_url Service endpoint base URL (defaults to ["https://www.googleapis.com/"]).
  @param std_params Optional standard parameters.
  *)
val getCertForOpenIdConnect :
  ?base_url:string ->
  ?std_params:GapiService.StandardParameters.t ->
  GapiConversation.Session.t ->
  GapiOauth2V2Model.Jwk.t * GapiConversation.Session.t

(** 
  
  @param base_url Service endpoint base URL (defaults to ["https://www.googleapis.com/"]).
  @param std_params Optional standard parameters.
  *)
val tokeninfo :
  ?base_url:string ->
  ?std_params:GapiService.StandardParameters.t ->
  ?access_token:string ->
  ?id_token:string ->
  ?token_handle:string ->
  GapiConversation.Session.t ->
  GapiOauth2V2Model.Tokeninfo.t * GapiConversation.Session.t

