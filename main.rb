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
    @feedback = []

    @current_guess.each_with_index do |color, i|
      if color == @code[i]
        @feedback.push('red')
      elsif @code.include?(color)
        @feedback.push('white')
      end
    end

    puts @feedback.shuffle
  end

  def won?
    true if @feedback == %w[red red red red]
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
