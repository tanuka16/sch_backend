class AuthController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)
    is_authenticated = user.authenticate(params[:password])

    if is_authenticated
      payload = {user_id: user.id}
      token = JWT.encode(payload, 'pegasuscode', 'HS256')
# this returns a js web token
      render json: {token: token}
    else
      render json: {errors: ["Invalid email id or password"]}, status: :unprocessable_entity
    end
  end
end

#

#   if user && user.authenticate(params[:password])
#     render json: user
#   else
#     render json: {errors: ["Wrong email id or password."]}, status: 422
#   end
