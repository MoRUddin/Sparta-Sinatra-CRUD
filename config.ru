require "sinatra"
require "sinatra/reloader" if development?
require_relative "./controllers/static_controller.rb"
require_relative "./controllers/movies_controller.rb"
require_relative "./controllers/directors_controller.rb"

use Rack::MethodOverride

run Rack::Cascade.new([
  MoviesController,
  DirectorsController,
  StaticController
])
