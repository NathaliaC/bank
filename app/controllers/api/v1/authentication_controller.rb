module Api::V1
  class AuthenticationController < Api::V1::ApiController
    skip_before_action :authenticate_request
 
    def authenticate
      command = AuthenticateUser.call(params[:email], params[:password])
   
      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end
