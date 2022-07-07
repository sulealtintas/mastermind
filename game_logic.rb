module GameLogic
  TURNS = 12
  COLORS = ['r','b','g','y','p','o']

  def compare(guess, code)
    used_indexes = []
    remaining_values = code.map(&:clone)
    exact_match = 0
    partial_match = 0

    guess.each_with_index do |n, i|
      next unless guess[i] == code[i]

      exact_match += 1
      remaining_values.delete_at(remaining_values.index(n))
      used_indexes.push(i)
    end

    guess.each_with_index do |n, i|
      next unless remaining_values.include?(n) && !used_indexes.include?(i)

      partial_match += 1
      remaining_values.delete_at(remaining_values.index(n))
      used_indexes.push(i)
    end

    { exact_match: exact_match, partial_match: partial_match }
  end

  def valid_code?(code)
    code.all? { |n| COLORS.to_a.include?(n) } && code.length == 4
  end
end
