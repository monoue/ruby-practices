# frozen_string_literal: true

require './lib/frame'

class Game
  def initialize(input)
    @marks = input.split(',')
    @frames = set_frames
  end

  def score
    frames.map(&:score).sum
  end

  private

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
