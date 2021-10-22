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
      add_frame(Frame.new(*marks[index..index + 2]))
      increments_frame_count
      break if frame_count == 10

      index += if marks[index] == 'X'
                 1
               else
                 2
               end
    end
  end

  def increments_frame_count
    @frame_count += 1
  end

  def add_frame(frame)
    @frames << frame
  end

  attr_reader :frames, :marks, :frame_count
end
