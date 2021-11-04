# frozen_string_literal: false

require_relative './file_status'
require_relative './long_format_line'
require_relative './entire_file_status_width'

class LongFormatBlock
  def initialize(filenames:, dir_path:)
    @filenames = filenames
    @dir_path = dir_path
  end

  def text
    file_statuses = filenames.map { |filename| FileStatus.new(filename: filename, dir_path: dir_path) }
    width = EntireFileStatusWidth.new(file_statuses)
    file_statuses.map { |file_status| LongFormatLine.new(file_status: file_status, width: width).text}.join
  end

  private

  attr_reader :filenames, :dir_path
end
