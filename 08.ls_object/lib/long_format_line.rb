class LongFormatLine
  attr_reader :data

  def initialize(info, width)
    @data = make_long_format_line(info, width)
  end

  def make_long_format_line(info, width)
    nlink_block = format '%*d', width.nlink, info.nlink
    owner_name_block = format '%-*s', width.owner_name, info.owner_name
    group_name_block = format '%-*s', width.group_name, info.group_name
    size_block = format '%*d', width.size, info.size
    "#{info.mode_block} #{nlink_block} #{owner_name_block}  #{group_name_block}  #{size_block} #{info.time_stamp} #{info.filename}\n"
  end
end
