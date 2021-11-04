# frozen_string_literal: false

require 'etc'
require_relative './mode_block'
require_relative './time_stamp'

class FileStatus
  attr_reader :filename, :mode_block, :nlink, :owner_name, :group_name, :size, :time_stamp, :blocks

  def initialize(filename:, dir_path:)
    @filename = filename
    full_path = "#{dir_path}/#{filename}"
    file_status = File.lstat(full_path)
    @mode_block = ModeBlock.new(file_status, full_path).text
    @nlink = file_status.nlink
    @owner_name = get_owner_name(file_status)
    @group_name = get_group_name(file_status)
    @size = file_status.size
    @time_stamp = TimeStamp.new(file_status.mtime).text
    @blocks = file_status.blocks
  end

  private

  def get_owner_name(file_status)
    Etc.getpwuid(file_status.uid).name
  end

  def get_group_name(file_status)
    Etc.getgrgid(file_status.gid).name
  end
end
