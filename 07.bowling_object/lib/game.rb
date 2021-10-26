# frozen_string_literal: true

require './lib/frame'

class Game
  def initialize(input)
    @marks = input.split(',')
    @frames = []
  end

  def result
    set_frames
    score
  end

  private

  def score
    frames.map(&:score).sum
  end

  def set_frames
    index = 0
    while frames.count < 10
      add_frame(Frame.new(*marks[index..index + 2]))
      index += marks[index] == 'X' ? 1 : 2
    end
  end

  def add_frame(frame)
    @frames << frame
  end

  attr_reader :frames, :marks, :frame_count
end
