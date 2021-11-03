# frozen_string_literal: false

require 'io/console'

class NormalFormatBlock
  attr_reader :text

  def initialize(filenames)
    @text = make_normal_dir_block(filenames)
  end

  private

  def make_normal_dir_block(filenames)
    return '' if filenames.size <= 0

    width_for_elem = get_width_for_elem(filenames)
    elems_num_per_line = IO.console.winsize[1] / width_for_elem
    rows_num = (filenames.size / elems_num_per_line.to_f).ceil
    str = ''
    (0...rows_num).each do |current_row|
      current_row.step(filenames.size - 1, rows_num) do |i|
        str << format('%-*s', width_for_elem - count_multibyte_chars(filenames[i]), filenames[i])
      end
      str.rstrip! << "\n"
    end
    str
  end

  def count_multibyte_chars(str)
    str.chars.count { |char| !char.ascii_only? }
  end

  def strlen_multibyte(str)
    str.length + count_multibyte_chars(str) * 2
  end

  def get_width_for_elem(filenames)
    filenames.map { |filename| strlen_multibyte(filename) }.max + 1
  end
end
