# frozen_string_literal: true

require 'mac'
require_relative './long_formats'
require_relative '../file_status'

module Sections
  class LongFormatFilesSection
    FILE_TYPE_CHAR = {
      'file' => '-',
      'directory' => 'd',
      'characterSpecial' => 'c',
      'blockSpecial' => 'b',
      'fifo' => 'p',
      'link' => 'l',
      'socket' => 's',
      'unknown' => ' '
    }.freeze

    def initialize(filenames, directory_path: '.')
      @filenames = filenames
      @directory_path = directory_path
      @file_statuses = filenames.map do |filename|
        FileStatus.new(filename, directory_path: directory_path)
      end
    end

    def format_section(display_total: false)
      return '' if file_statuses.empty?

      entire_file_status_width = build_entire_file_status_width
      section = file_statuses.map.with_index do |file_status, i|
        full_path = "#{directory_path}/#{filenames[i]}"
        lstat = File.lstat(full_path)
        file_mode = build_file_mode(lstat, full_path)
        long_format_line = LongFormats::LongFormatLine.new(file_status, entire_file_status_width)
        "#{file_mode} #{long_format_line.format_line}"
      end.join("\n")
      display_total ? "#{make_total_blocks_line}#{section}\n" : "#{section}\n"
    end

    private

    attr_reader :filenames, :directory_path, :file_statuses

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

    def build_file_mode(file_lstat, full_path)
      FILE_TYPE_CHAR[file_lstat.ftype] + LongFormats::Permission.new(file_lstat).format_permission + Mac.new.attr(full_path)
    end
  end
end
