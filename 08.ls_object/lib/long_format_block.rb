# frozen_string_literal: false

require_relative './long_format_line_info'
require_relative './long_format_line'
require_relative './width'

class LongFormatBlock
  attr_reader :text

  def initialize(filenames, dir_path)
    @text = make_long_format_block(filenames, dir_path)
  end

  private

  def make_long_format_block(filenames, dir_path)
    long_format_line_infos = LongFormatLineInfo.make_arr(filenames, dir_path)
    width = Width.new(long_format_line_infos)
    str = ''
    long_format_line_infos.each do |info|
      str << LongFormatLine.new(info, width).text
    end
    str
  end
end
