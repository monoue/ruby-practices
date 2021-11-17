# frozen_string_literal: false

require 'io/console'

module Sections
  class NormalFormatFilesSection
    def initialize(filenames:, directory_path: '.')
      @filenames = filenames
      @directory_path = directory_path
    end

    def to_s
      return '' if filenames.empty?

      file_statuses = filenames.map do |filename|
        FileStatus.new(filename: filename)
      end
      width_for_filename = calculate_width_for_filename(file_statuses)
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

    attr_reader :filenames, :directory_path

    def calculate_width_for_filename(file_statuses)
      file_statuses.max_by(&:multibyte_filename_length).multibyte_filename_length + 1
    end
  end
end
