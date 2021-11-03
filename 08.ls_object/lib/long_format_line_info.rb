# frozen_string_literal: false

require 'etc'
require_relative './mode_block'
require_relative './time_stamp'

class LongFormatLineInfo
  attr_reader :filename, :mode_block, :nlink, :owner_name, :group_name, :size, :time_stamp, :blocks

  def initialize(filename, dir_path)
    @filename = filename
    full_path = "#{dir_path}/#{filename}"
    file_info = File.lstat(full_path)
    @mode_block = ModeBlock.new(file_info, full_path).text
    @nlink = file_info.nlink
    @owner_name = get_owner_name(file_info)
    @group_name = get_group_name(file_info)
    @size = file_info.size
    @time_stamp = TimeStamp.new(file_info.mtime).text
    @blocks = file_info.blocks
  end

  def self.make_arr(filenames, dir_path)
    long_format_line_infos = []
    filenames.each do |filename|
      long_format_line_infos << LongFormatLineInfo.new(filename, dir_path)
    end
    long_format_line_infos
  end

  private

  def get_owner_name(file_info)
    Etc.getpwuid(file_info.uid).name
  end

  def get_group_name(file_info)
    Etc.getgrgid(file_info.gid).name
  end
end
