# frozen_string_literal: true

require_relative './long_formats'
require_relative '../file_status'

module Sections
  class LongFormatFilesSection
    def initialize(filenames, directory_path: '.')
      @file_statuses = filenames.map do |filename|
        FileStatus.new(filename, directory_path: directory_path)
      end
      @total_blocks = total_blocks
    end

    def format_section(displays_total_blocks: false)
      return '' if file_statuses.empty?

      entire_file_status_width = LongFormats::EntireFileStatusWidth.new(file_statuses)
      section = file_statuses.map do |file_status|
        LongFormats::LongFormatLine.new(file_status, entire_file_status_width).format_line
      end.join("\n")
      displays_total_blocks ? "#{make_total_blocks_line}#{section}\n" : "#{section}\n"
    end

    private

    attr_reader :file_statuses

    def make_total_blocks_line
      total_blocks = file_statuses.map(&:blocks).sum
      "total #{total_blocks}\n"
    end
  end
end
