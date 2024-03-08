require 'sinatra'
require './play.rb'

get '/' do
  erb :index
end

post '/guess' do
  # Create a new instance of your Hangman game
  game = Hangman.new

  # Call the make_guess method with the guess from the form
  game.make_guess(params['guess'])

  # Redirect back to the index page
  redirect to('/')
end