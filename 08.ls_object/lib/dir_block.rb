class DirBlock
  attr_reader :data

  def initialize(dir_path, option)
    @data = make_dir_block(dir_path, option)
  end

  private

  def make_dir_block(dir_path, option)
    filenames = init_filenames(dir_path, option)
    dir_block = option.long_format ? LongFormat.make_long_format_dir_block(filenames, dir_path) : NormalFormat.make_normal_dir_block(filenames)
    ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block}" : dir_block
  end

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
