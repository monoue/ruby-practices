# frozen_string_literal: false

require 'etc'
require_relative './mode_block'
require_relative './time_stamp'

class FileStatus
  attr_reader :filename

  def initialize(filename:, directory_path:)
    @filename = filename
    @full_path = "#{directory_path}/#{filename}"
    @lstat = File.lstat(full_path)
  end

  def mode_block
    ModeBlock.new(lstat, full_path).to_s
  end

  def nlink
    lstat.nlink
  end

  def owner_name
    Etc.getpwuid(lstat.uid).name
  end

  def group_name
    Etc.getgrgid(lstat.gid).name
  end

  def file_size
    lstat.size
  end

  def time_stamp
    TimeStamp.new(lstat.mtime).to_s
  end

  def blocks
    lstat.blocks
  end

  private

  attr_reader :full_path, :lstat
end
