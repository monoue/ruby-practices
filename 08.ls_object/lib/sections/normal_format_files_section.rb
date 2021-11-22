# frozen_string_literal: true

require 'io/console'

module Sections
  class NormalFormatFilesSection
    def initialize(filenames, directory_path: '.')
      @filenames = filenames
      @directory_path = directory_path
    end

    def format_section
      return '' if filenames.empty?

      file_statuses = filenames.map do |filename|
        FileStatus.new(filename)
      end
      multibyte_width_for_filename = calculate_multibyte_width_for_filename(file_statuses)
      filenames_num_per_line = IO.console.winsize[1] / multibyte_width_for_filename
      rows_num = (file_statuses.size / filenames_num_per_line.to_f).ceil
      rows = []
      (0...rows_num).each do |current_row|
        cols = []
        current_row.step(file_statuses.size - 1, rows_num) do |i|
          file_status = file_statuses[i]
          width_for_filename = multibyte_width_for_filename - file_status.multibyte_chars_of_filename_num
          cols << format('%-*s', width_for_filename, file_status.filename)
        end
        rows << cols.join.rstrip
      end
      rows.join("\n")
    end

    private

    attr_reader :filenames, :directory_path

    def calculate_multibyte_width_for_filename(file_statuses)
      file_statuses.map(&:multibyte_filename_length).max + 1
    end
  end
end
