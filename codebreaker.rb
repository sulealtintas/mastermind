require './game_logic'

class Codebreaker
  include GameLogic
  attr_reader :current_guess
  attr_accessor :feedback

  def initialize(game)
    @game = game
  end

  def make_guess
    puts 'Make your guess!'
    @current_guess = gets.chomp.downcase.split('')
    until valid_code?(@current_guess)
      puts "Wrong input! Try again:"
      @current_guess = gets.chomp.downcase.split('')
    end
  end

  def win
    puts "YOU WIN! You broke the code in #{@game.turn} turns."
  end

  def lose
    puts "YOU LOSE! You ran out of turns."
  end
end