class MoviesController < Sinatra::Base
  #sets root of the parent directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  #sets the view directory correctly
  set :view, Proc.new { File.join(root,"views")}

  #Enable reloader
  configure :development do
    register Sinatra::Reloader
  end

  $movies = [
    {
      id: 0,
      title: "The Shrek Shank Rededemption",
      body: "A Big Green Ogre Cowboy."
    },
    {
      id: 1,
      title: "Pokemon the First Movie: Mewtwo Strikes Back",
      body: "Attack of the Clone."
    },
    {
      id: 2,
      title: "Kung Fu Hustle",
      body: "Pretty cool, hilarious action movie."
    },
    {
      id: 3,
      title: "Deadpool 2",
      body: "It's about time"
    }
  ]

  get '/movies' do
    @movies = $movies
    erb :'/movies/index'
  end

  get '/movies/:id' do
    @title = $movies[params[:id].to_i][:title]
    @body = $movies[params[:id].to_i][:body]
    @movie = $movies[params[:id].to_i]
    @movies = $movies
    erb :'/movies/show'
  end

  get '/movies/:id/edit' do
    @title = "#{$movies[params[:id].to_i][:title]} Edit"
    @movie = $movies[params[:id].to_i]
    erb :'/movies/edit'
  end

  put '/movies/:id'  do

    id = params[:id].to_i
    movie = $movies[id]
    movie[:title] = params[:title]
    movie[:body] = params[:body]
    $movies[id] = movie

    redirect '/movies'

  end

  delete '/movies/:id'  do

    id = params[:id].to_i
    $movies.delete_at(id)
    redirect '/movies'

  end

  post '/movies' do

    new_movie = {
      title: params[:title],
      body: params[:body]
    }

    $movies.push(new_movie)

    redirect "/movies"

  end

end
