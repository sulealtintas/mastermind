class Game
  COLORS = %w[blue green red yellow orange purple]
  TURNS = 12
  attr_reader :code, :current_guess

  def initialize
    @code = COLORS.sample(4)
  end

  def guess
    puts 'Make your guess!'
    @current_guess = gets.chomp.downcase.split
  end

  def give_feedback
    exact_match = 0
    color_match = 0

    @current_guess.each_with_index do |color, i|
      if color == @code[i]
        exact_match += 1
      elsif @code.include?(color)
        color_match += 1
      end
    end

    puts "Correct color and position: #{exact_match}"
    puts "Correct color, wrong position: #{color_match}"
  end

  def won?
    true if @current_guess == @code
  end

  def play
    TURNS.times do
      guess
      give_feedback
      if won?
        puts 'YOU WIN!'
        break
      end
    end
    puts 'GAME OVER. You ran out of turns!' unless won?
  end
end

game = Game.new
game.play
