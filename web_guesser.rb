require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
    guess = params['guess']
    message = check_guess(guess)
    erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
    if !guess
        message = "Enter a guess"
    else
        guess = guess.to_i
        if guess - 5 > SECRET_NUMBER
            message = "Way too high! Try again"
        elsif guess > SECRET_NUMBER
            message = "Too high! Try again"
        elsif guess + 5 < SECRET_NUMBER
            message = 'Way too low! Try again'
        elsif guess < SECRET_NUMBER
            message = 'Too low! Try again'
        else
            message = "Correct! The secret number was #{SECRET_NUMBER}"
        end
    end
end

