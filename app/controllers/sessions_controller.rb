class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if uer && user.authenticate(params[:session][:password])

    else

    end
  end

  def destroy

  end
end
