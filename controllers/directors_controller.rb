class DirectorsController < Sinatra::Base
  #sets root of the parent directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  #sets the view directory correctly
  set :view, Proc.new { File.join(root,"views")}

  #Enable reloader
  configure :development do
    register Sinatra::Reloader
  end

  $directors = [
    {
      id: 0,
      name: "Frank Adam Darabont Adamson"
    },
    {
      id: 1,
      name: "Kunihiko Yuyama"
    },
    {
      id: 2,
      name: "Stephen Chow"
    },
    {
      id: 3,
      name: "Tim Miller"
    }
  ]

  get '/directors' do
    @title = "Directors Index Page"
    @directors = $directors
    erb :'/directors/index'
  end

  get '/directors/:id' do
    @title = $directors[params[:id].to_i][:name]
    @body = $directors[params[:id].to_i][:body]
    @director = $directors[params[:id].to_i]
    @directors = $directors
    erb :'/directors/show'
  end

  get '/directors/:id/edit' do
    @title = "#{$directors[params[:id].to_i][:title]} Edit"
    @director = $directors[params[:id].to_i]
    erb :'/directors/edit'
  end

  put '/directors/:id'  do

    id = params[:id].to_i
    director = $directors[id]
    director[:title] = params[:title]
    director[:body] = params[:body]
    $directors[id] = director

    redirect '/directors'

  end

  delete '/directors/:id'  do

    id = params[:id].to_i
    $directors.delete_at(id)
    redirect '/directors'

  end

  post '/directors' do

    new_director = {
      title: params[:title],
      body: params[:body]
    }

    $directors.push(new_director)

    redirect "/directors"

  end

end
