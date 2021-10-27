require 'mac'
require_relative './permission'

class ModeBlock
  attr_reader :data

  def initialize(file_info, filename)
    @data = get_mode_block(file_info, filename)
  end

  private

  def get_mode_block(file_info, filename)
    "#{get_file_type(file_info)}#{Permission.new(file_info).data}#{Mac.new.attr(filename)}"
  end

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
