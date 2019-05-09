require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
    guess = params['guess']
    result = check_guess(guess)
    message = result[0]
    background_color = result[1]
    erb :index, :locals => {:message => message, :bgcolor => background_color}
end

def check_guess(guess)
    if !guess
        message = "Enter a guess"
        color = 'white'
    else
        guess = guess.to_i
        if guess - 5 > SECRET_NUMBER
            message = "Way too high! Try again"
            color = 'red'
        elsif guess > SECRET_NUMBER
            message = "Too high! Try again"
            color = 'lightcoral'
        elsif guess + 5 < SECRET_NUMBER
            message = 'Way too low! Try again'
            color = 'red'
        elsif guess < SECRET_NUMBER
            message = 'Too low! Try again'
            color = 'lightcoral'
        else
            message = "Correct! The secret number was #{SECRET_NUMBER}"
            color = 'lime'
        end
    end

    return [message, color]
end