class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    @recipe = Recipe.new(params)
    if @recipe.save
      redirect to "/recipes/#{@recipe.id}"
    else
      redirect to '/recipes/new'
    end
  end

  get '/recipes/new' do
    erb :create
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(id: params["id"])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(id: params["id"])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(id: params["id"])
    @recipe.update(params["recipes"])
    erb :show
  end

  delete '/recipes/:id/delete' do
    Recipe.delete(params["id"])
    redirect to '/recipes'
  end

end
