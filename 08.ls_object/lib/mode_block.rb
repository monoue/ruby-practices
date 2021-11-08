# frozen_string_literal: true

require 'mac'
require_relative './permission'

class ModeBlock
  def initialize(file_lstat, full_path)
    @file_lstat = file_lstat
    @full_path = full_path
  end

  def to_s
    get_file_type(file_lstat) + Permission.new(file_lstat).to_s + Mac.new.attr(full_path)
  end

  private

  attr_reader :file_lstat, :full_path

  def get_file_type(file_lstat)
    return 'b' if file_lstat.blockdev?

    return 'c' if file_lstat.chardev?

    return 'd' if file_lstat.directory?

    return 'l' if file_lstat.symlink?

    return 'p' if file_lstat.pipe?

    return 's' if file_lstat.socket?

    return '-' if file_lstat.file?

    ' '
  end
end
