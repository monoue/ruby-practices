# frozen_string_literal: false

require 'mac'
require 'etc'

module Permission
  class << self
    def char_bit_set?(char)
      char == '1'
    end

    def get_readable_and_writable_s(permission_binary_s)
      readable_c = char_bit_set?(permission_binary_s[-3]) ? 'r' : '-'
      writable_c = char_bit_set?(permission_binary_s[-2]) ? 'w' : '-'
      "#{readable_c}#{writable_c}"
    end

    def get_executable_or_not_char(permission_binary_c)
      char_bit_set?(permission_binary_c) ? 'x' : '-'
    end

    def get_owner_or_group_permission(permission_binary_s, set_user_or_group_id)
      readable_and_writable_s = get_readable_and_writable_s(permission_binary_s)
      if set_user_or_group_id
        "#{readable_and_writable_s}#{char_bit_set?(permission_binary_s[-1]) ? 's' : 'S'}"
      else
        "#{readable_and_writable_s}#{get_executable_or_not_char(permission_binary_s[-1])}"
      end
    end

    def get_other_permission(permission_binary_s, sticky)
      readable_and_writable_s = get_readable_and_writable_s(permission_binary_s)
      if sticky
        "#{readable_and_writable_s}#{char_bit_set?(permission_binary_s[-1]) ? 't' : 'T'}"
      else
        "#{readable_and_writable_s}#{get_executable_or_not_char(permission_binary_s[-1])}"
      end
    end
  end

  private_class_method :char_bit_set?, :get_readable_and_writable_s, :get_owner_or_group_permission, :get_other_permission

  def self.get_permission(file_info)
    mode_octal = file_info.mode.to_s(8)
    permission_strs = {}
    permission_strs[:owner] = get_owner_or_group_permission(mode_octal[-3].to_i.to_s(2), file_info.setuid?)
    permission_strs[:group] = get_owner_or_group_permission(mode_octal[-2].to_i.to_s(2), file_info.setgid?)
    permission_strs[:other] = get_other_permission(mode_octal[-1].to_i.to_s(2), file_info.sticky?)
    permission_strs.values.join
  end
end

module Mode
  class << self
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

    def get_mac_extended_attributes(full_path)
      mac = Mac.new
      mac.attr(full_path)
    end
  end

  private_class_method :get_file_type, :get_mac_extended_attributes

  def self.get_mode_block(file_info, filename)
    "#{get_file_type(file_info)}#{Permission.get_permission(file_info)}#{get_mac_extended_attributes(filename)}"
  end
end

module TimeStamp
  class << self
    def recent?(file_mtime)
      return false if file_mtime > Time.now

      six_month = 60 * 60 * 24 * 365.2425 / 2
      file_mtime.to_f >= Time.now.to_f - six_month
    end

    def get_time_or_year(file_mtime)
      if recent?(file_mtime)
        format '%<hour>02d:%<min>02d', hour: file_mtime.hour, min: file_mtime.min
      else
        format '%5d', file_mtime.year
      end
    end
  end

  private_class_method :recent?, :get_time_or_year

  def self.get_time_stamp(file_mtime)
    month = format '%2d', file_mtime.month
    day = format '%2d', file_mtime.day
    time_or_year = get_time_or_year(file_mtime)
    "#{month} #{day} #{time_or_year}"
  end
end

module LongFormat
  class << self
    def get_owner_name(file_info)
      Etc.getpwuid(file_info.uid).name
    end

    def get_group_name(file_info)
      Etc.getgrgid(file_info.gid).name
    end

    def get_long_format_line_info(filename, dir_path)
      full_path = "#{dir_path}/#{filename}"
      file_info = File.lstat(full_path)
      {
        filename: filename,
        mode_block: Mode.get_mode_block(file_info, full_path),
        nlink: file_info.nlink,
        owner_name: get_owner_name(file_info),
        group_name: get_group_name(file_info),
        size: file_info.size,
        time_stamp: TimeStamp.get_time_stamp(file_info.mtime),
        blocks: file_info.blocks
      }
    end

    def init_long_format_line_infos(filenames, dir_path)
      long_format_line_infos = []
      filenames.each do |filename|
        long_format_line_infos << get_long_format_line_info(filename, dir_path)
      end
      long_format_line_infos
    end

    def count_digits(num)
      Math.log10(num.abs).to_i + 1
    rescue FloatDomainError
      1
    end

    def init_widths(long_format_line_infos)
      nlink_width = long_format_line_infos.map { |info| count_digits(info[:nlink]) }.max
      owner_name_width = long_format_line_infos.map { |info| info[:owner_name].length }.max
      group_name_width = long_format_line_infos.map { |info| info[:group_name].length }.max
      size_width = long_format_line_infos.map { |info| count_digits(info[:size]) }.max
      { nlink: nlink_width, owner_name: owner_name_width, group_name: group_name_width, size: size_width }
    end

    def make_long_format_line(info, widths)
      nlink_block = format '%*d', widths[:nlink], info[:nlink]
      owner_name_block = format '%-*s', widths[:owner_name], info[:owner_name]
      group_name_block = format '%-*s', widths[:group_name], info[:group_name]
      size_block = format '%*d', widths[:size], info[:size]
      "#{info[:mode_block]} #{nlink_block} #{owner_name_block}  #{group_name_block}  #{size_block} #{info[:time_stamp]} #{info[:filename]}\n"
    end

    def make_total_blocks_line(total_blocks)
      "total #{total_blocks}\n"
    end
  end

  private_class_method :get_owner_name, :get_group_name, :get_long_format_line_info, :init_long_format_line_infos, :count_digits, :init_widths,\
                       :make_long_format_line, :make_total_blocks_line

  class << self
    def make_long_format_block(filenames, dir_path)
      long_format_line_infos = init_long_format_line_infos(filenames, dir_path)
      widths = init_widths(long_format_line_infos)
      str = ''
      long_format_line_infos.each do |info|
        str << make_long_format_line(info, widths)
      end
      str
    end

    def make_long_format_dir_block(filenames, dir_path)
      return '' if filenames.size <= 0

      long_format_block = make_long_format_block(filenames, dir_path)
      long_format_line_infos = init_long_format_line_infos(filenames, dir_path)
      total_blocks = long_format_line_infos.map { |info| info[:blocks] }.sum
      "#{make_total_blocks_line(total_blocks)}#{long_format_block}"
    end
  end
end
