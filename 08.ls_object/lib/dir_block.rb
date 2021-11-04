# frozen_string_literal: true

require_relative './long_format_dir_block'
require_relative './normal_format_block'

class DirBlock
  def initialize(dir_path:, option:)
    @dir_path = dir_path
    @option = option
  end

  def text
    filenames = init_filenames(dir_path, option)
    dir_block_str = option.long_format? ? LongFormatDirBlock.new(filenames: filenames, dir_path: dir_path).text : NormalFormatBlock.new(filenames).text
    ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block_str}" : dir_block_str
  end

  private

  attr_reader :dir_path, :option

  def make_dir_block_header_line(dir_path)
    "#{dir_path}:\n"
  end

  def init_filenames(dir_path, option)
    filenames = Dir.entries(dir_path)
    filenames = filenames.reject { |filename| filename[0] == '.' } unless option.all?
    filenames.sort!
    option.reverse? ? filenames.reverse : filenames
  end
end
