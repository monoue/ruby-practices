# frozen_string_literal: false

require 'etc'
require_relative './file_mode'
require_relative './time_stamp'

module Sections
  module LongFormats
    class FileStatus
      attr_reader :filename

      def initialize(filename:, directory_path:)
        @filename = filename
        @full_path = "#{directory_path}/#{filename}"
        @lstat = File.lstat(full_path)
      end

      def mode
        FileMode.new(lstat, full_path).to_s
      end

      def nlink
        lstat.nlink
      end

      def owner_name
        Etc.getpwuid(lstat.uid).name
      end

      def group_name
        Etc.getgrgid(lstat.gid).name
      end

      def file_size
        lstat.size
      end

      def time_stamp
        TimeStamp.new(lstat.mtime).to_s
      end

      def blocks
        lstat.blocks
      end

      private

      attr_reader :full_path, :lstat
    end
  end
end
