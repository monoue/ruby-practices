class Ls
  attr_reader :result

  def initialize(option)
    @option = Option.new
    @result = make_result
  end

  private

  def make_result
    return DirSection.new('.') if ARGV.empty?
    #
    # paths = ClassifyAndSort.classify_and_sort_paths(options[:reverse])
    # noent_block = make_noent_block(paths[:paths_not_exist])
    # body_blocks = make_body_blocks(paths, options)
    # "#{noent_block}#{body_blocks.join("\n")}"
  end

  def make_dir_block(dir_path)
    filenames = init_filenames(dir_path)
    dir_block = options[:long_format] ? LongFormat.make_long_format_dir_block(filenames, dir_path) : NormalFormat.make_normal_dir_block(filenames)
    ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block}" : dir_block
  end

  def init_filenames(dir_path)
    filenames = Dir.entries(dir_path)
    filenames = filenames.reject { |filename| filename[0] == '.' } unless options[:all]
    filenames.sort!
    options[:reverse] ? filenames.reverse : filenames
  end

  attr_reader :option
end
