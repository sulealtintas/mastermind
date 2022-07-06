require './game_logic'

class Game
  include GameLogic
  TURNS = 12

  def initialize
    @code = Array.new(4) { (1..6).to_a.sample }.map(&:to_s)
    puts @code
  end

  def guess
    puts 'Make your guess!'
    @current_guess = gets.chomp.downcase.split('')
    until valid_code?(@current_guess)
      puts "Wrong input! Try again:"
      @current_guess = gets.chomp.downcase.split('')
    end
  end

  def give_feedback
    feedback = compare(@current_guess, @code)

    puts "Correct number and position: #{feedback[:exact_match]}"
    puts "Correct number, wrong position: #{feedback[:partial_match]}"
  end

  def play
    TURNS.times do |i|
      puts "Turn #{i}"
      guess
      give_feedback
      if solved?(@current_guess, @code)
        puts 'YOU WIN!'
        return
      end
    end
    puts 'GAME OVER. You ran out of turns!'
  end
end

game = Game.new
game.play
