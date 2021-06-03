# frozen_string_literal: false

require 'io/console'
require_relative './long_format'

module NormalFormat
  class << self
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

  private_class_method :count_multibyte_chars, :strlen_multibyte, :get_width_for_elem

  def self.make_normal_dir_block(filenames)
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
end

module DirBlock
  class << self
    def make_dir_block_header_line(dir_path)
      "#{dir_path}:\n"
    end

    def init_filenames(dir_path, options)
      filenames = Dir.entries(dir_path)
      filenames = filenames.reject { |filename| filename[0] == '.' } unless options[:all]
      filenames.sort!
      options[:reverse] ? filenames.reverse : filenames
    end
  end

  private_class_method :make_dir_block_header_line, :init_filenames

  class << self
    def make_dir_block(dir_path, options)
      filenames = init_filenames(dir_path, options)
      dir_block = options[:long_format] ? LongFormat.make_long_format_dir_block(filenames, dir_path) : NormalFormat.make_normal_dir_block(filenames)
      ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block}" : dir_block
    end

    def make_dir_blocks(dir_paths, options)
      dir_blocks = []
      dir_paths.each do |dir_path|
        dir_blocks << make_dir_block(dir_path, options)
      end
      dir_blocks
    end
  end
end
