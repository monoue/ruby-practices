# frozen_string_literal: true

require 'mac'
require_relative './permission'

class ModeBlock
  def initialize(file_info, filename)
    @file_info = file_info
    @filename = filename
  end

  def text
    "#{get_file_type(file_info)}#{Permission.new(file_info).text}#{Mac.new.attr(filename)}"
  end

  private

  attr_reader :file_info, :filename

  def get_file_type(file_info)
    return 'b' if file_info.blockdev?

    return 'c' if file_info.chardev?

    return 'd' if file_info.directory?

    return 'l' if file_info.symlink?

    return 'p' if file_info.pipe?

    return 's' if file_info.socket?

    return '-' if file_info.file?

    ' '
  end
end
