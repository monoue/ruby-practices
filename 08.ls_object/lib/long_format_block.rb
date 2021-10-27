class LongFormatBlock
  attr_reader :data

  def initialize(filenames, dir_path)
    @data = make_long_format_block(filenames, dir_path)
  end

  private

  def make_long_format_block(filenames, dir_path)
    # long_format_line_infos = make_long_format_line_infos(filenames, dir_path)
    long_format_line_infos = LongFormatLineInfo.make_arr(filenames, dir_path)
    width = Width.new(long_format_line_infos)
    str = ''
    long_format_line_infos.each do |info|
      str << LongFormatLine.new(info, width).data
    end
    str
  end

  # def make_long_format_line_infos(filenames, dir_path)
  #   long_format_line_infos = []
  #   filenames.each do |filename|
  #     long_format_line_infos << LongFormatLineInfo.new(filename, dir_path)
  #   end
  #   long_format_line_infos
  # end
end
