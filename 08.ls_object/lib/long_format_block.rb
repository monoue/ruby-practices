# frozen_string_literal: false

require_relative './file_status'
require_relative './long_format_line'
require_relative './entire_file_status_width'

class LongFormatBlock
  def initialize(filenames:, directory_path:)
    @filenames = filenames
    @directory_path = directory_path
  end

  def text
    file_statuses = filenames.map { |filename| FileStatus.new(filename: filename, directory_path: directory_path) }
    entire_file_status_width = EntireFileStatusWidth.new(file_statuses)
    file_statuses.map { |file_status| LongFormatLine.new(file_status: file_status, entire_file_status_width: entire_file_status_width).text }.join
  end

  private

  attr_reader :filenames, :directory_path
end
