class UsersController < ApplicationController
  # creates new users
  # ENCODING here
  def create
    user = User.create(user_params)

    if user.valid?
      payload = {user_id: user.id}
      token = JWT.encode(payload, 'pegasuscode', 'HS256')          # giving a token
# this returns a js web token

      render json: {token: token}                                     # returning a token
    else
      render json: { errors: user.errors.full_messages}, status: :unprocessable_entity
    end

  end
# if you're using web token, for everytime you talk to your server, the 1st step will be establishing that its you, either through creating an account or login
# 2nd step, everytime after that (we already have a token) everytime you talk to a server you just send the token back wwith any request you make, in the header using the key authorization.
# Make a request to profile and check for that key
# DECODING here
  def profile
    # (1) the request go into the headers and grab the key authorization and give us the value back (this's the token our server gave us originally)
    # the server only knows about the system
    # byebug/
    token = request.headers["Authorization"]
    # what makes it secure? only the server knows about the secret 'pegasuscode'; the data is encoded using this secret, only server knows it so when server gets the information back, it must be the same information server encoded using the secret. Otherwise, it will break.
    # server uses the secret to encode and decode information
    decoded_token = JWT.decode(token, 'pegasuscode', true, { algorithm: 'HS256' })

    user_id = decoded_token[0]["user_id"]               # user id

    user = User.find(user_id)

    # get the user back
    render json: user
  end

   private

   def user_params
     # require returns only the username or email; in rails api, by default you don't need the require.
     # params.require(:user).permit(:email, :password)
     params.permit(:email, :password)

   end
end
