require './game_logic'

class ComputerCodebreaker < Codebreaker
  def initialize(game)
    super
    @possible_codes = (1111..6666).to_a
                                  .map { |code| code.to_s.split('') }
                                  .select { |code| valid_code?(code) }
  end

  def make_guess
    if feedback
      @possible_codes.each_index do |i|
        @possible_codes.delete_at(i) if compare(@current_guess, @possible_codes[i]) != @feedback
      end
    end
    @current_guess = @possible_codes.sample(1)[0]
    @possible_codes.delete(@current_guess)
    puts "Computer guesses #{current_guess.join('')}"
  end

  def win
    puts "Computer wins! The computer broke the code in #{@game.turn} turns."
  end

  def lose
    puts 'The computer ran out of turns!'
  end
end
