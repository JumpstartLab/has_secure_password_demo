class SessionsController < ApplicationController
  def create
    username = params[:session][:name]
    password = params[:session][:password]

    user = User.find_by_username(username)

    if user
      result = user.authenticate(password)
      if result
        session[:user_id] = result.id
        redirect_to pages_path
      else
        render :text => "Found the user #{user}, but the PW was wrong"
      end
    else
      # print an error
      render :text => "User #{username} not found, brah"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to pages_path
  end
end
