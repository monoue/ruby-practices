# frozen_string_literal: true

require 'mac'
require_relative './long_formats'
require_relative '../file_status'

module Sections
  class LongFormatFilesSection
    def self.format_section(filenames, directory_path = '.', display_total: false)
      new(filenames, directory_path).format_section(display_total: display_total)
    end

    def initialize(filenames, directory_path = '.')
      @filenames = filenames
      @directory_path = directory_path
    end

    def format_section(display_total: false)
      return '' if filenames.empty?

      file_statuses = filenames.map do |filename|
        FileStatus.new(filename, directory_path)
      end
      entire_file_status_width = build_entire_file_status_width(file_statuses)
      section = file_statuses.map do |file_status|
        LongFormats::LongFormatLine.format_line(file_status, entire_file_status_width)
      end.join("\n")
      display_total ? "#{make_total_blocks_line(file_statuses)}\n#{section}" : section
    end

    private

    attr_reader :filenames, :directory_path

    def make_total_blocks_line(file_statuses)
      total_blocks = file_statuses.map(&:blocks).sum
      "total #{total_blocks}"
    end

    StatusWidth = Struct.new(:nlink, :owner_name, :group_name, :file_size)

    def build_entire_file_status_width(file_statuses)
      max_nlink_width = 0
      max_owner_name_width = 0
      max_group_name_width = 0
      max_size_width = 0
      file_statuses.each do |file_status|
        max_nlink_width = [file_status.nlink.to_s.size, max_nlink_width].max
        max_owner_name_width = [file_status.owner_name.size, max_owner_name_width].max
        max_group_name_width = [file_status.group_name.size, max_group_name_width].max
        max_size_width = [file_status.file_size.to_s.size, max_size_width].max
      end
      StatusWidth.new(max_nlink_width, max_owner_name_width, max_group_name_width, max_size_width)
    end
  end
end
