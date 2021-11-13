# frozen_string_literal: false

require 'etc'
require_relative './sections/long_formats/file_mode'
require_relative './sections/long_formats/time_stamp'

class FileStatus
  attr_reader :filename

  def initialize(filename:, directory_path: '.')
    @filename = filename
    @full_path = "#{directory_path}/#{filename}"
    @lstat = File.lstat(full_path)
  end

  def mode
    Sections::LongFormats::FileMode.new(lstat, full_path)
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
    Sections::LongFormats::TimeStamp.new(lstat.mtime)
  end

  def blocks
    lstat.blocks
  end

  def multibyte_filename_length
    filename.length + multibyte_chars_of_filename_num * 2
  end

  def multibyte_chars_of_filename_num
    filename.chars.count { |char| !char.ascii_only? }
  end

  private

  attr_reader :full_path, :lstat
end
