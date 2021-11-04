# frozen_string_literal: true

class LongFormatLine
  def initialize(file_status:, entire_file_status_width:)
    @file_status = file_status
    @entire_file_status_width = entire_file_status_width
  end

  def text
    nlink_block = format '%*d', entire_file_status_width.nlink, file_status.nlink
    owner_name_block = format '%-*s', entire_file_status_width.owner_name, file_status.owner_name
    group_name_block = format '%-*s', entire_file_status_width.group_name, file_status.group_name
    size_block = format '%*d', entire_file_status_width.size, file_status.file_size
    "#{file_status.mode_block} #{nlink_block} #{owner_name_block}  #{group_name_block}  #{size_block} #{file_status.time_stamp} #{file_status.filename}\n"
  end

  private

  attr_reader :file_status, :entire_file_status_width
end
