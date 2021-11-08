# frozen_string_literal: false

require 'io/console'

class NormalFormatFilesSection
  def initialize(filenames)
    @filenames = filenames
  end

  def to_s
    return '' if filenames.empty?

    width_for_filename = get_width_for_filename(filenames)
    filenames_num_per_line = IO.console.winsize[1] / width_for_filename
    rows_num = (filenames.size / filenames_num_per_line.to_f).ceil
    str = ''
    (0...rows_num).each do |current_row|
      current_row.step(filenames.size - 1, rows_num) do |i|
        str << format('%-*s', width_for_filename - count_multibyte_chars(filenames[i]), filenames[i])
      end
      str.rstrip! << "\n"
    end
    str
  end

  private

  attr_reader :filenames

  def count_multibyte_chars(str)
    str.chars.count { |char| !char.ascii_only? }
  end

  def strlen_multibyte(str)
    str.length + count_multibyte_chars(str) * 2
  end

  def get_width_for_filename(filenames)
    filenames.map { |filename| strlen_multibyte(filename) }.max + 1
  end
end
