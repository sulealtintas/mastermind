module GameLogic
  def compare(guess, code)
    used_values = []
    exact_match = 0
    partial_match = 0

    code.each_with_index do |n, i|
      if n == guess[i]
        exact_match += 1
        used_values.push(i)
      end
    end

    code.each_with_index do |color, i|
      if guess.include?(color) & !used_values.include?(i)
        partial_match += 1
        used_values.push(i)
      end
    end

    { exact_match: exact_match, partial_match: partial_match }
  end

  def solved?(guess, code)
    true if guess == code
  end

  def valid_code?(code)
    code.all? { |n| (1..6).to_a.include?(n.to_i) } && code.length == 4
  end
end
