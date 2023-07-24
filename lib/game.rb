# require 'pry-byebug'; binding.pry

class Game
    attr_accessor :current_guess, :guesses_left

    def initialize(guesses_left)
        @dictionary = create_dictionary()
        @secret_word = choose_secret_word()
        @current_guess = ["_"] * @secret_word.length
        @guesses_left = guesses_left + 1
        puts @secret_word
    end


    def over?()
        @guesses_left -= 1
        if @guesses_left == 0
            puts "The game is over. The correct ward was: #{@secret_word}"
        elsif @current_guess.join() == @secret_word
            puts "Congratulations, you guessed the word!"
        else
            return false
        end
        return true
    end


    def check_guess(guess)
        iterable = @secret_word.split("")
        iterable.each_with_index do |char, index|
            @current_guess[index] = guess if char == guess 
        end
    end

    private
    def create_dictionary()
        words = Array.new
        File.foreach("10000_words.txt") do |line|
            word = line.strip
            words.push(word) if (word.length > 4 && word.length < 13)
        end
        return words
    end

    private
    def choose_secret_word()
        n = rand(0..@dictionary.length)
        return @dictionary[n]
    end
end