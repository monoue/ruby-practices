# frozen_string_literal: true

require_relative './long_formats'

module Sections
  class LongFormatFilesSection
    def initialize(filenames, directory_path: '.')
      @filenames = filenames
      @directory_path = directory_path
    end

    def format_section
      file_statuses = filenames.map do |filename|
        FileStatus.new(filename, directory_path: directory_path)
      end
      entire_file_status_width = LongFormats::EntireFileStatusWidth.new(file_statuses)
      file_statuses.map do |file_status|
        LongFormats::LongFormatLine.new(file_status, entire_file_status_width).format_line
      end.join
    end

    private

    attr_reader :filenames, :directory_path
  end
end
