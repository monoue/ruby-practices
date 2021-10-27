# frozen_string_literal: true

require './lib/frame'

class Game
  attr_reader :score

  def initialize(input)
    @marks = input.split(',')
    @frames = set_frames
    @score = set_score
  end

  private

  def set_score
    frames.map(&:score).sum
  end

  def set_frames
    frames = []
    index = 0
    while frames.count < 10
      frames << Frame.new(*marks[index..index + 2])
      index += marks[index] == 'X' ? 1 : 2
    end
    frames
  end

  attr_reader :frames, :marks
end
