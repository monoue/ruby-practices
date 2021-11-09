# frozen_string_literal: false

require_relative './long_formats'

class LongFormatFilesSection
  def initialize(filenames:, directory_path:)
    @filenames = filenames
    @directory_path = directory_path
  end

  def to_s
    file_statuses = filenames.map do |filename|
      FileStatus.new(filename: filename, directory_path: directory_path)
    end
    entire_file_status_width = EntireFileStatusWidth.new(file_statuses)
    file_statuses.map do |file_status|
      LongFormatLine.new(
        file_status: file_status,
        entire_file_status_width: entire_file_status_width
      ).to_s
    end.join
  end

  private

  attr_reader :filenames, :directory_path
end
