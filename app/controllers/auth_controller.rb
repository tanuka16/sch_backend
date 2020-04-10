class AuthController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    is_authenticated = user.authenticate(params[:password])

    if is_authenticated
      render json: user
    else
      render json: {errors: ["Invalid email id or password"]}, status: 422
    end
  end
end

#

#   if user && user.authenticate(params[:password])
#     render json: user
#   else
#     render json: {errors: ["Wrong email id or password."]}, status: 422
#   end
