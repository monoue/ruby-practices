# frozen_string_literal: false

require 'etc'
require_relative './mode_block'
require_relative './time_stamp'

class FileStatus
  attr_reader :filename

  def initialize(filename:, directory_path:)
    @filename = filename
    @full_path = "#{directory_path}/#{filename}"
    @file_status = File.lstat(full_path)
  end

  def mode_block
    ModeBlock.new(file_status, full_path).text
  end

  def nlink
    file_status.nlink
  end

  def owner_name
    Etc.getpwuid(file_status.uid).name
  end

  def group_name
    Etc.getgrgid(file_status.gid).name
  end

  def file_size
    file_status.size
  end

  def time_stamp
    TimeStamp.new(file_status.mtime).text
  end

  def blocks
    file_status.blocks
  end

  private

  attr_reader :full_path, :file_status
end
