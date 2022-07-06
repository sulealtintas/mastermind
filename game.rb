require './game_logic'
require './human_codebreaker'
require './computer_codebreaker'

class Game
  include GameLogic
  attr_reader :turn

  def play
    show_instructions

    @game_mode = select_mode
    create_code
    create_codebreaker
    12.times do |i|
      @turn = i + 1
      puts "\nTurn #{@turn}"
      @codebreaker.make_guess
      give_feedback
      if @codebreaker.current_guess == @secret_code
        @codebreaker.win
        return
      end
      sleep(1) if @game_mode == '2'
    end
    @codebreaker.lose
    puts "The secret code was #{@secret_code.join('')}."
  end

  def select_mode
    puts "Select your game mode by inputting '1' or '2'"
    puts '1: Player as codebreaker'
    puts '2: Computer as codebreaker'
    game_mode = gets.chomp
    until %w[1 2].include?(game_mode)
      puts "Please input either '1' or '2'"
      game_mode = gets.chomp
    end
    game_mode
  end

  def create_codebreaker
    case @game_mode
    when '1'
      @codebreaker = HumanCodebreaker.new(self)
    when '2'
      @codebreaker = ComputerCodebreaker.new(self)
    end
  end

  def create_code
    case @game_mode
    when '1'
      @secret_code = random_code
    when '2'
      @secret_code = input_code
    end
  end

  def random_code
    Array.new(4) { (1..6).to_a.sample }.map(&:to_s)
  end

  def input_code
    puts 'Choose your secret code!'
    code = gets.chomp.downcase.split('')
    until valid_code?(code)
      puts 'Wrong input! Try again:'
      code = gets.chomp.downcase.split('')
    end
    code
  end

  def give_feedback
    @codebreaker.feedback = compare(@codebreaker.current_guess, @secret_code)

    puts "Correct number and position: #{@codebreaker.feedback[:exact_match]}"
    puts "Correct number, wrong position: #{@codebreaker.feedback[:partial_match]}"
  end
end

def show_instructions
  puts 'MASTERMIND'
  puts 'The game will be played against the computer.'
  puts 'You can play as either the code creator or breaker.'
  puts 'The code creator will create a code of exactly 4 digits, each between 1 and 6.'
  puts "The code breaker must correctly guess the code in no more than 12 turns."
  puts 'After each guess, there will be hints showing how close the guess was to the code.'
end