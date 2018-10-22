require 'sinatra'
require './utils'

enable :sessions

get '/' do
  erb :index
end

get '/caesar_cipher' do
  encrypted_message = nil
  erb :caesar_cipher, locals: {encrypted_message: encrypted_message}
end

post '/caesar_cipher' do
  message = params[:message]
  number = params[:number]
  encrypted_message = caesar_cipher(message, number)
  erb :caesar_cipher, locals: {encrypted_message: encrypted_message}
end




game = Game.new

get '/new_hangman' do
  game = Game.new
  redirect '/hangman'
end

get '/hangman' do
  game.compare(params[:letter])  unless params[:letter].nil?
  session[:random_word] = game.random_word
  session[:guessed_word] = game.guessed_word
  session[:misses] = game.misses
  session[:available_chances] = game.available_chances
  erb :hangman, locals:{ game: game, random_word: session[:random_word],
                         guessed_word: session[:guessed_word], misses: session[:misses],
                         available_chances: session[:available_chances]}
end
