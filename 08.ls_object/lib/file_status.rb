# frozen_string_literal: true

require 'etc'

class FileStatus
  attr_reader :filename, :full_path, :lstat

  def initialize(filename, directory_path = '.')
    @filename = filename
    @full_path = "#{directory_path}/#{filename}"
    @lstat = File.lstat(@full_path)
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
    lstat.mtime
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
end
