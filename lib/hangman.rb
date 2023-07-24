require_relative 'game'

game = Game.new(10)
guess = String.new

until game.over?
    puts "You have #{game.guesses_left} guesses left. \nCurrent guess: #{game.current_guess.join()}"
    loop do
        puts "Guess a letter:"
        guess = gets.chomp
        break if guess.count("a-zA-Z") > 0
    end
    game.check_guess(guess)
end