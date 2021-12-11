# frozen_string_literal: true

require_relative './long_formats'
require_relative '../file_status'

module Sections
  class LongFormatFilesSection
    def initialize(filenames, directory_path: '.')
      @file_statuses = []
      @long_format_line_sets = []
      filenames.each do |filename|
        file_status = FileStatus.new(filename, directory_path: directory_path)
        @file_statuses << file_status
        full_path = "#{directory_path}/#{filename}"
        lstat = File.lstat(full_path)
        file_mode = LongFormats::FileMode.new(lstat, full_path)
        @long_format_line_sets << { file_mode: file_mode, file_status: file_status}
      end
    end

    def format_section(display_total: false)
      return '' if long_format_line_sets.empty?

      entire_file_status_width = build_entire_file_status_width
      section = long_format_line_sets.map do |long_format_line_set|
        file_mode = long_format_line_set[:file_mode]
        long_format_line = LongFormats::LongFormatLine.new(long_format_line_set[:file_status], entire_file_status_width)
        "#{file_mode} #{long_format_line.format_line}"
      end.join("\n")
      display_total ? "#{make_total_blocks_line}#{section}\n" : "#{section}\n"
    end

    private

    attr_reader :file_statuses, :long_format_line_sets

    def make_total_blocks_line
      total_blocks = file_statuses.map(&:blocks).sum
      "total #{total_blocks}\n"
    end

    StatusWidth = Struct.new(:nlink, :owner_name, :group_name, :file_size)

    def build_entire_file_status_width
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
