class Ls
  attr_reader :result

  def initialize
    @option = Option.new
    @result = make_result
  end

  private

  def make_result
    path_info = PathInfo.new(option.reverse?)
    noent_section = make_noent_section(path_info.paths_not_exist)
    body = Body.new(path_info, option)
    "#{noent_section}#{body.join('\n')}"
  end

  def make_body(path_info, option)
    files_block = option.long_format? ? LongFormat.make_long_format_block(path_info.files, '.') : NormalFormat.make_normal_dir_block(path_info.files)
    dir_blocks = DirBlock.make_dir_blocks(paths[:directories], options)
    files_block.length.positive? ? dir_blocks.unshift(files_block) : dir_blocks
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

  def make_noent_section(paths_not_exist)
    section = ''
    paths_not_exist.each do |path|
      section << "ls: #{path}: No such file or directory\n"
    end
    section
  end

  attr_reader :option
end
