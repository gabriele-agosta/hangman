require_relative 'game'

def save_game(game)
  File.open("saved_games/#{game.current_guess.join}", 'w') { |file| file.write(Marshal.dump(game)) }
  puts 'Game saved succesfully!'
end

def list_saved_games()
  hash = Hash.new
  list = Dir.entries('saved_games') - %w[. ..]
  list.each_with_index do |file, index|
    puts "#{index} - #{file}"
    hash[index] = file
  end
  return hash
end

def choose_game(saved_games)
  puts 'Choose the game you want to load (Use its index)'
  choice = String.new
  loop do
    choice = gets.chomp.downcase.to_i
    break if saved_games.key?(choice)
  end
  return choice
end

def load_game(game_chosen)
  return Marshal.load(File.binread("saved_games/#{game_chosen}"))
end

load_game = String.new
guess = String.new
save = String.new

puts 'Would you like to load a saved game? (yes/no)'
loop do
  load_game = gets.chomp.downcase
  break if load_game == "yes" || load_game == "no"
end

if load_game == "no" 
  game = Game.new(20)
else
  saved_games = list_saved_games()
  game_chosen = choose_game(saved_games)
  game = load_game(saved_games[game_chosen])
end

until game.over?
  puts "You have #{game.guesses_left} guesses left. \nCurrent guess: #{game.current_guess.join}"
    loop do
      puts 'Would you like to save the current game? (yes/no)'
      loop do
        save = gets.chomp.downcase
        break if save == 'yes' || save == 'no'
      end
      save_game(game) if save == 'yes'
      puts 'Guess a letter:'
      guess = gets.chomp.downcase
      break if guess.count('a-zA-Z').positive?
    end
  game.check_guess(guess)
end