class MealsController < ApplicationController
  get '/meals' do
    if logged_in?
      @meals = current_user.meals.all
      erb :'meals/meals'
    else
      redirect to '/login'
    end
  end

  post '/meals' do
    if logged_in?
      if params[:name] == ""
        redirect to "/login"
      else
        @meal = current_user.meals.new(name: params[:name], calories: params[:calories])
        if @meal.save
          redirect to "/meals/#{@meal.id}"
        else
          redirect to "/meals/new"
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/meals/create_meal' do
    if logged_in?
      erb :'meals/create_meal'
    else
      redirect to '/login'
    end
  end

  get '/meals/:id' do
    if logged_in?
      @meal = Meal.find_by_id(params[:id])
      erb :'meals/show_meal'
    else
      redirect to '/login'
    end
  end

  get '/meals/:id/edit' do
    if logged_in?
      @meal = Meal.find_by_id(params[:id])
      if @meal && @meal.user == current_user
        erb :'meals/edit_meal'
      else
        redirect to '/meals'
      end
    else
      redirect to '/login'
    end
  end

  patch '/meals/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/meals/#{params[:id]}/edit"
      else
        @meal = meal.find_by_id(params[:id])
        if @meal && @meal.user == current_user
          if @meal.update(name: params[:name], calories: params[:calories])
            redirect to "/meals/#{@meal.id}"
          else
            redirect to "/meals/#{@meal.id}/edit"
          end
        else
          redirect to '/meals'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/meals/:id/delete' do
    if logged_in?
      @meal = Meal.find_by_id(params[:id])
      if @meal && @meal.user == current_user
        @meal.delete
      end
      redirect to '/meals'
    else
      redirect to '/login'
    end
  end
end
