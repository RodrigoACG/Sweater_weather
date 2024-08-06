class Api::V1::SessionsController < ApplicationController 

  def create
    user = User.find_by(email: session_params[:email])
    
    # require 'pry'; binding.pry
    if user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { errors: "Email or Passowrd is incorrect, Please Try Again!" }, status: 401
    end
  end

  private

  def session_params
    payload = JSON.parse(request.body.read, symbolize_names: true)
    ActionController::Parameters.new(payload).permit(:email, :password)
  end 
end