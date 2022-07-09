require './game_rules'
require './human_codebreaker'
require './computer_codebreaker'

class Game
  include GameRules
  attr_reader :turn

  def initialize
    @turns = GameRules::TURNS
    @color_names = GameRules::COLOR_NAMES
    @color_codes = GameRules::COLOR_CODES
  end

  def play
    show_instructions
    select_mode
    create_code
    create_codebreaker
    game_loop
  end

  def game_loop
    @turns.times do |i|
      puts "\nTurn #{i+1}"
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
    @game_mode = gets.chomp
    until %w[1 2].include?(@game_mode)
      puts "Please input either '1' or '2'"
      @game_mode = gets.chomp
    end
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
    @color_codes.sample(4)
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

    puts "Correct color and position: #{@codebreaker.feedback[:exact_match]}"
    puts "Correct color, wrong position: #{@codebreaker.feedback[:partial_match]}"
  end
end

def show_instructions
  puts 'MASTERMIND'
  puts 'The game will be played against the computer.'
  puts 'You can play as either the maker or breaker of a secret code of exactly 4 colors.'
  print 'There are 6 possible colors: '
  @color_names[0..4].each do |color|
    print "#{color[0]} for #{color}, "
  end
  print "and #{@color_names[-1][0]} for #{@color_names[-1]}.\n"
  puts "For example: 'roob' for red-orange-orange-blue."
  puts "The code breaker must correctly guess the code in no more than #{@turns} turns."
  puts 'After each guess, there will be hints showing how close the guess was to the code.'
end
