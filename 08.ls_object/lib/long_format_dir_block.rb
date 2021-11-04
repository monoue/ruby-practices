# frozen_string_literal: true

require_relative './file_status'
require_relative './long_format_block'

class LongFormatDirBlock
  def initialize(filenames:, dir_path:)
    @filenames = filenames
    @dir_path = dir_path
  end

  def text
    return '' if filenames.size <= 0

    long_format_block = LongFormatBlock.new(filenames: filenames, dir_path: dir_path)
    long_format_line_infos = filenames.map { |filename| FileStatus.new(filename: filename, dir_path: dir_path) }
    total_blocks = long_format_line_infos.map(&:blocks).sum
    "#{make_total_blocks_line(total_blocks)}#{long_format_block.text}"
  end

  private

  attr_reader :filenames, :dir_path

  def make_total_blocks_line(total_blocks)
    "total #{total_blocks}\n"
  end
end
