# frozen_string_literal: true

require_relative './permission'

module Sections
  module LongFormats
    class LongFormatLine
      include LongFormats::Permission

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

      def initialize(file_status, entire_file_status_width)
        @file_status = file_status
        @entire_file_status_width = entire_file_status_width
      end

      def format_line
        nlink_block = format '%*d', entire_file_status_width.nlink, file_status.nlink
        owner_name_block = format '%-*s', entire_file_status_width.owner_name, file_status.owner_name
        group_name_block = format '%-*s', entire_file_status_width.group_name, file_status.group_name
        file_size_block = format '%*d', entire_file_status_width.file_size, file_status.file_size
        formatted_timestamp = format_timestamp(file_status.time_stamp)
        mode = build_file_mode
        "#{mode} #{nlink_block} #{owner_name_block}  #{group_name_block}  #{file_size_block} #{formatted_timestamp} #{file_status.filename}"
      end

      private

      attr_reader :file_status, :entire_file_status_width

      def format_timestamp(file_mtime)
        if recent?(file_mtime)
          file_mtime.strftime('%_m %e %R')
        else
          file_mtime.strftime('%_m %e %_5Y')
        end
      end

      # テスト容易性のためにメソッド化
      def current_time
        Time.now
      end

      def recent?(file_mtime)
        return false if file_mtime > current_time

        days_per_year = 365.2425
        half_a_year_by_the_second = 60 * 60 * 24 * days_per_year / 2
        file_mtime.to_f >= current_time.to_f - half_a_year_by_the_second
      end

      def build_file_mode
        FILE_TYPE_CHAR[@file_status.lstat.ftype] + format_permission(@file_status.lstat) + Mac.new.attr(@file_status.full_path)
      end
    end
  end
end
