class Game
  TURNS = 12

  def initialize
    @code = (1..6).to_a.sample(4).map(&:to_s)
  end

  def guess
    puts 'Make your guess!'
    @current_guess = gets.chomp.downcase.split('')
  end

  def give_feedback
    exact_match = 0
    number_match = 0

    @current_guess.each_with_index do |color, i|
      if color == @code[i]
        exact_match += 1
      elsif @code.include?(color)
        number_match += 1
      end
    end

    puts "Correct number and position: #{exact_match}"
    puts "Correct number, wrong position: #{number_match}"
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
