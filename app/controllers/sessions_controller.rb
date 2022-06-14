class SessionsController < ApplicationController
  include ActionController::Cookies
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      render json: {id:user.id, display_name: user.display_name}, status: 201
    else
      render json: { message: "emailまたはpasswordが間違っています" }, status: 400
    end
  end

  def destroy
    if logged_in?
      log_out
      render json: {message: "logout successfuly"}, status: 204
    else
      cookies.delete :_session_id
      render json: {message: "loginされていません"}, status: 401
    end
  end
end
