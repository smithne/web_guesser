require 'sinatra'
require 'sinatra/reloader'

num = rand(100)

get '/' do
    "The secret number is #{num}"
end

