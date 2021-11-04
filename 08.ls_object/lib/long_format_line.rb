# frozen_string_literal: true

class LongFormatLine
  attr_reader :text

  def initialize(file_status:, width:)
    @text = make_long_format_line(file_status, width)
  end

  def make_long_format_line(file_status, width)
    nlink_block = format '%*d', width.nlink, file_status.nlink
    owner_name_block = format '%-*s', width.owner_name, file_status.owner_name
    group_name_block = format '%-*s', width.group_name, file_status.group_name
    size_block = format '%*d', width.size, file_status.size
    "#{file_status.mode_block} #{nlink_block} #{owner_name_block}  #{group_name_block}  #{size_block} #{file_status.time_stamp} #{file_status.filename}\n"
  end
end
