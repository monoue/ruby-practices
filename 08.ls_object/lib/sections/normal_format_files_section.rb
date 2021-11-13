# frozen_string_literal: false

require 'io/console'

module Sections
  class NormalFormatFilesSection
    def initialize(file_statuses)
      @file_statuses = file_statuses
    end

    def to_s
      return '' if file_statuses.empty?

      width_for_filename = calculate_width_for_filename
      filenames_num_per_line = IO.console.winsize[1] / width_for_filename
      rows_num = (file_statuses.size / filenames_num_per_line.to_f).ceil
      str = ''
      (0...rows_num).each do |current_row|
        current_row.step(file_statuses.size - 1, rows_num) do |i|
          str << format(
            '%-*s',
            width_for_filename - file_statuses[i].multibyte_chars_of_filename_num, file_statuses[i].filename
          )
        end
        str.rstrip! << "\n"
      end
      str
    end

    private

    attr_reader :file_statuses

    def calculate_width_for_filename
      file_statuses.max_by(&:multibyte_filename_length).multibyte_filename_length + 1
    end
  end
end
