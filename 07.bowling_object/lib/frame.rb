# frozen_string_literal: true

require './lib/shot'

class Frame
  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    if strike || spare
      [first_shot.score, second_shot.score, third_shot.score].sum
    else
      first_shot.score + second_shot.score
    end
  end

  private

  def strike
    first_shot.score == 10
  end

  def spare
    first_shot.score + second_shot.score == 10
  end

  attr_reader :first_shot, :second_shot, :third_shot
end
