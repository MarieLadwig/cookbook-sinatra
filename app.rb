require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require "./lib/cookbook.rb"
require "./lib/recipe.rb"
require "./lib/scraper.rb"
require 'nokogiri'
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

COOKBOOK = Cookbook.new('./lib/recipes.csv')

get '/' do
  @recipes = COOKBOOK.all
  erb :index
end

get '/new' do
  erb :create
end

get '/post' do
  name = params[:name]
  description = params[:description]
  difficulty = params[:difficulty]
  prep_time = params[:prep_time]
  recipe = Recipe.new(name, description, difficulty, prep_time)
  COOKBOOK.add_recipe(recipe)
  redirect to '/'
end

get '/delete' do
  @recipes = COOKBOOK.all
  erb :delete
end

get '/remove_index' do
  index = params[:index].to_i
  COOKBOOK.remove_recipe(index)
  redirect to '/'
end

get '/view' do
  index = params[:index].to_i
  @recipe_to_display = COOKBOOK.all[index]
  erb :show_details
end

get '/import' do
  erb :import
end

SUGGESTIONS = []

get '/scrape' do
  ingredient = params[:ingredient]
  scrape = Scraper.new(ingredient)
  generated_suggestions = scrape.obtain_scraped_info
  SUGGESTIONS = generated_suggestions
  @Suggestions = SUGGESTIONS
  erb :show_suggestions
end

get '/save' do
  index = params[:index].to_i
  imported_recipe = SUGGESTIONS[index]
  COOKBOOK.add_recipe(imported_recipe)
  redirect to '/'
end
