# frozen_string_literal: true

require './lib/frame'

class Game
  def initialize(input)
    @marks = input.split(',')
    @frame_count = 0
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
    loop do
      add_frame(Frame.new(*(marks[index..index + 2])))
      increments_frame_count
      if frame_count == 10
        break
      elsif marks[index] == 'X'
        index += 1
      else
        index += 2
      end
    end
  end

  def increments_frame_count
    @frame_count += 1
  end

  def add_frame(frame)
    @frames << frame
  end

  def frames
    @frames
  end

  def marks
    @marks
  end

  def frame_count
    @frame_count
  end
end
