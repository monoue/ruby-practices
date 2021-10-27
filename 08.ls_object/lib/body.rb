class Body
  attr_reader :data

  def initialize(path_info, option)
    @data = make_body(path_info, option)
  end

  private

  def make_body(path_info, option)
    files_block = option.long_format? ? LongFormat.make_long_format_block(path_info.files, '.') : NormalFormat.make_normal_dir_block(path_info.files)
    dir_blocks = DirBlock.make_dir_blocks(paths[:directories], options)
    files_block.length.positive? ? dir_blocks.unshift(files_block) : dir_blocks
  end

  attr_reader :path_info, :option
end
