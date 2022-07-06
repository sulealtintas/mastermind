require './game_logic'
require './codebreaker'

class Game
  include GameLogic
  attr_reader :turn
  TURNS = 12

  def play
    puts 'MASTERMIND'
    create_code
    create_codebreaker
    TURNS.times do |i|
      @turn = i+1
      puts "\nTurn #{@turn}"
      @codebreaker.make_guess
      give_feedback
      if @codebreaker.current_guess == @secret_code
        @codebreaker.win
        return
      end
    end
    @codebreaker.lose
    puts "The secret code was #{@secret_code.join('')}."
  end

  def create_codebreaker
    @codebreaker = Codebreaker.new(self)
  end

  def create_code
    @secret_code = Array.new(4) { (1..6).to_a.sample }.map(&:to_s)
  end

  def give_feedback
    @codebreaker.feedback = compare(@codebreaker.current_guess, @secret_code)

    puts "Correct number and position: #{@codebreaker.feedback[:exact_match]}"
    puts "Correct number, wrong position: #{@codebreaker.feedback[:partial_match]}"
  end
end

game = Game.new
game.play