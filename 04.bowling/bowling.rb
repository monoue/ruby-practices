#!/usr/bin/env ruby

# frozen_string_literal: true

def turn_arg_into_int_arr
  ARGV[0].split(',').map do |arg|
    if arg == 'X'
      10
    else
      arg.to_i
    end
  end
end

def calc_bonus_score(scores)
  bonus_score = 0
  first_throw = true
  frame_count = 1
  scores.each_with_index do |score, i|
    return bonus_score if frame_count == 10

    if first_throw
      if score == 10
        frame_count += 1
        bonus_score += scores[i + 1..i + 2].sum
      else
        first_throw = false
      end
    else
      bonus_score += scores[i + 1] if score + scores[i - 1] == 10
      frame_count += 1
      first_throw = true
    end
  end
end

scores = turn_arg_into_int_arr
puts scores.sum + calc_bonus_score(scores)
