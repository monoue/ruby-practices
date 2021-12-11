# frozen_string_literal: true

require 'mac'
require_relative './permission'

module Sections
  module LongFormats
    class FileMode
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

      def initialize(file_lstat, full_path)
        @file_lstat = file_lstat
        @full_path = full_path
      end

      def to_s
        FILE_TYPE_CHAR[file_lstat.ftype] + Permission.new(file_lstat).format_permission + Mac.new.attr(full_path)
      end

      private

      attr_reader :file_lstat, :full_path
    end
  end
end
