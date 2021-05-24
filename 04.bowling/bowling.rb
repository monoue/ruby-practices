#!/usr/bin/env ruby

# frozen_string_literal: true

scores = ARGV[0].split(',').map do |arg|
  if arg == 'X'
    10
  else
    arg.to_i
  end
end

bonus_score = 0
first_throw = true
frame_count = 1

scores.each_with_index do |score, i|
  break if frame_count == 10

  if first_throw
    if score == 10
      frame_count += 1
      bonus_score += scores[i + 1 .. i + 2].sum
    else
      first_throw = false
    end
  else
    bonus_score += scores[i + 1] if score + scores[i - 1] == 10
    frame_count += 1
    first_throw = true
  end
end

p scores.sum + bonus_score