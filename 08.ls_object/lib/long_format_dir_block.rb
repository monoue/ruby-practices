require_relative './long_format_line_info'
require_relative './long_format_block'

class LongFormatDirBlock
  attr_reader :data

  def initialize(filenames, dir_path)
    @data = make_long_format_dir_block(filenames, dir_path)
  end

  def make_long_format_dir_block(filenames, dir_path)
    return '' if filenames.size <= 0

    # long_format_block = make_long_format_block(filenames, dir_path)
    long_format_block = LongFormatBlock.new(filenames, dir_path)
    # long_format_line_infos = init_long_format_line_infos(filenames, dir_path)
    long_format_line_infos = LongFormatLineInfo.make_arr(filenames, dir_path)
    total_blocks = long_format_line_infos.map { |info| info.blocks }.sum
    "#{make_total_blocks_line(total_blocks)}#{long_format_block.data}"
  end

  def make_total_blocks_line(total_blocks)
    "total #{total_blocks}\n"
  end
end
