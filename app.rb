require 'sinatra'
require "sinatra/reloader" if development?
require './play.rb'
require 'openssl'

enable :sessions
set :session_secret, "a07fe457ad5d6666f85deea571790db75d925df0cdaf0828813f6dd40524101a"

get '/' do
    session[:game] = Hangman.new unless session[:game]
    erb :index, locals: { game: session[:game] }
end

post '/guess' do
    begin
      guess = params['guess']
      game = session[:game]
      game.make_guess(guess)
      redirect to('/')
    rescue ArgumentError => e
        erb :index, locals: { game: session[:game], message: e.message }
    end
    
  end