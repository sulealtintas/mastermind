class Game
  TURNS = 12

  def initialize
    @code = Array.new(4) { (1..6).to_a.sample }.map(&:to_s)
    puts @code
  end

  def guess
    puts 'Make your guess!'
    @current_guess = gets.chomp.downcase.split('')
    p @current_guess
    until @current_guess.all? { |n| (1..6).to_a.include?(n.to_i) } && @current_guess.length == 4
      puts "Wrong input! Try again:"
      @current_guess = gets.chomp.downcase.split('')
    end
  end

  def give_feedback
    exact_match = 0
    partial_match = 0
    used_values = []

    @code.each_with_index do |color, i|
      if color == @current_guess[i]
        exact_match += 1
        used_values.push(i)
      end
    end

    @code.each_with_index do |color, i|
      if @current_guess.include?(color) & !used_values.include?(i)
        partial_match += 1
        used_values.push(i)
      end
    end

    puts "Correct number and position: #{exact_match}"
    puts "Correct number, wrong position: #{partial_match}"
  end

  def won?
    true if @current_guess == @code
  end

  def play
    TURNS.times do |i|
      puts "Turn #{i}"
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
