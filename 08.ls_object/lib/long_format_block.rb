# frozen_string_literal: false

require_relative './file_status'
require_relative './long_format_line'
require_relative './width'

class LongFormatBlock
  attr_reader :text

  def initialize(filenames:, dir_path:)
    @text = make_long_format_block(filenames, dir_path)
  end

  private

  def make_long_format_block(filenames, dir_path)
    file_statuses = filenames.map { |filename| FileStatus.new(filename: filename, dir_path: dir_path) }
    width = Width.new(file_statuses)
    str = ''
    file_statuses.each do |file_status|
      str << LongFormatLine.new(file_status: file_status, width: width).text
    end
    str
  end
end
