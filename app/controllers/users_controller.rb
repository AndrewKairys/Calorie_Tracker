class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in!"}
    else
      redirect to '/meals'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" || params[:daily_calories] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email],
        :password => params[:password], :daily_calories => params[:daily_calories])
      @user.save
      session[:user_id] = @user.id
      redirect to '/meals'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/meals'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/meals"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/'
    else
      redirect to '/'
    end
  end

end
