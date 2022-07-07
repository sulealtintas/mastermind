class Codebreaker
  include GameRules
  attr_reader :current_guess
  attr_accessor :feedback

  def initialize(game)
    @game = game
  end

  def make_guess
    raise NotImplementedError
  end

  def win
    raise NotImplementedError
  end

  def lose
    raise NotImplementedError
  end
end
