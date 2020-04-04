class AuthController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    is_authenticated = user.authenticate(params[:password])

    if is_authenticated
      render json: user
    else
      render json: {errors: ["Wrong email id or password."]}, status: :unprocessable_entity
    end
  end
end
