require 'sinatra'
require 'sinatra/reloader'
require 'active_support/inflector'

@@secret_number = rand(100)
@@guesses = 5
@@winner = false

get '/' do

    guess = params['guess']
    @@guesses -= 1 unless (guess == "" || guess.nil?)
    result = check_guess(guess)
    background_color = result[1]
    if @@winner
        message = result[0]
        @@guesses = 5
        @@secret_number = rand(100)
        @@winner = false
    elsif @@guesses > 0
        message = result[0]
        message +=  " #{@@guesses} #{pluralize(@@guesses,'guess')} remaining."
    else
        message = "Out of guesses. You lose! New number generated."
        background_color = 'white'
        @@guesses = 5
        @@secret_number = rand(100)
    end

    message += ("  " + @@secret_number.to_s)

    erb :index, :locals => {:message => message, :bgcolor => background_color}

end

def check_guess(guess)
    if !guess || guess == ""
        message = "Enter a guess."
        color = 'white'
    else
        guess = guess.to_i
        if guess - 5 > @@secret_number
            message = "Way too high! Try again."
            color = 'red'
        elsif guess > @@secret_number
            message = "Too high! Try again."
            color = 'lightcoral'
        elsif guess + 5 < @@secret_number
            message = "Way too low! Try again."
            color = 'red'
        elsif guess < @@secret_number
            message = "Too low! Try again."
            color = 'lightcoral'
        else
            message = "Correct! The secret number was #{@@secret_number}. New number generated."
            color = 'lime'
            @@winner = true
        end
    end

    return [message, color]
end

def pluralize(number, text)
    return text.pluralize if number != 1
    text
end