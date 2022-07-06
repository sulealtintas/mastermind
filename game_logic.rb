module GameLogic
  def compare(guess, code)
    used_indexes = []
    remaining_values = code.map(&:clone)
    exact_match = 0
    partial_match = 0

    guess.each_with_index do |n, i|
      if guess[i] == code[i]
        exact_match += 1
        remaining_values.delete_at(remaining_values.index(n))
        used_indexes.push(i)
      end
    end

    guess.each_with_index do |n, i|
      if remaining_values.include?(n) and !used_indexes.include?(i)
        partial_match += 1
        remaining_values.delete_at(remaining_values.index(n))
        used_indexes.push(i)
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
