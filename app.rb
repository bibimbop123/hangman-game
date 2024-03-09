require 'sinatra'
require "sinatra/reloader" if development?
require './play.rb'
require 'openssl'

enable :sessions
set :session_secret, "a07fe457ad5d6666f85deea571790db75d925df0cdaf0828813f6dd40524101a"

get '/' do
    session[:game] = Hangman.new unless session[:game]
    @lives = session[:game].lives
    game_won = session[:game].won? # Replace with your method to check if the game is won
    erb :index, locals: { game: session[:game], game_won: game_won }
  end

  post '/guess' do
    begin
      guess = params['guess']
      game = session[:game]
      game.make_guess(guess)
      session[:lives] = game.lives
      game_won = game.won? # Add this line
      redirect to('/')
    rescue ArgumentError => e
      erb :index, locals: { game: session[:game], message: e.message, game_won: game_won } # Add game_won here
    end
  end

  post '/reset' do
    session[:game] = Hangman.new
    redirect to('/')
  end
