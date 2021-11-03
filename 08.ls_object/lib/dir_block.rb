# frozen_string_literal: true

require_relative './long_format_dir_block'
require_relative './normal_format_block'

class DirBlock
  attr_reader :text

  def initialize(dir_path, option)
    @text = make_dir_block(dir_path, option)
  end

  def self.make_arr(dir_paths, option)
    dir_blocks = []
    dir_paths.each do |dir_path|
      dir_blocks << DirBlock.new(dir_path, option)
    end
    dir_blocks
  end

  private

  def make_dir_block(dir_path, option)
    filenames = init_filenames(dir_path, option)
    dir_block_str = option.long_format? ? LongFormatDirBlock.new(filenames, dir_path).text : NormalFormatBlock.new(filenames).text
    ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block_str}" : dir_block_str
  end

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
