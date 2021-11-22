# frozen_string_literal: true

module Sections
  module LongFormats
    class LongFormatLine
      def initialize(file_status, entire_file_status_width)
        @file_status = file_status
        @entire_file_status_width = entire_file_status_width
      end

      def format_line
        nlink_block = format '%*d', entire_file_status_width.nlink, file_status.nlink
        owner_name_block = format '%-*s', entire_file_status_width.owner_name, file_status.owner_name
        group_name_block = format '%-*s', entire_file_status_width.group_name, file_status.group_name
        file_size_block = format '%*d', entire_file_status_width.size, file_status.file_size
        formatted_timestamp = format_timestamp(file_status.time_stamp)
        "#{file_status.mode} #{nlink_block} #{owner_name_block}  #{group_name_block}  #{file_size_block} #{formatted_timestamp} #{file_status.filename}"
      end

      private

      attr_reader :file_status, :entire_file_status_width

      def format_timestamp(file_mtime)
        month = format '%2d', file_mtime.month
        day = format '%2d', file_mtime.day
        time_or_year = get_time_or_year(file_mtime)
        "#{month} #{day} #{time_or_year}"
      end

      def get_time_or_year(file_mtime)
        if recent?(file_mtime)
          format '%<hour>02d:%<min>02d', hour: file_mtime.hour, min: file_mtime.min
        else
          format '%5d', file_mtime.year
        end
      end

      def recent?(file_mtime)
        return false if file_mtime > Time.now

        six_month = 60 * 60 * 24 * 365.2425 / 2
        file_mtime.to_f >= Time.now.to_f - six_month
      end
    end
  end
end
