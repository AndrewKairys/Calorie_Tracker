require './config/environment'

class ApplicationController < Sinatra::Base

  configure :development do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "calorie tracker session secret"
    set :sessions, :expire_after => 3600
    set :database, 'sqlite3:db/development.db'
  end

  get '/' do
    if logged_in?
      redirect to '/meals'
    else
      erb :index
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if !!session[:user_id]
    end

  end
end
