require 'mac'
require 'etc'

def get_file_type(file_info)
  if file_info.blockdev? then 'b'
  elsif file_info.chardev? then 'c'
  elsif file_info.directory? then 'd'
  elsif file_info.symlink? then 'l'
  elsif file_info.pipe? then 'p'
  elsif file_info.socket? then 's'
  elsif file_info.file? then '-'
  else ' '
  end
end

module Permission
  class << self
    def char_bit_set?(c)
      c == '1'
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

def get_mac_extended_attributes(full_path)
  mac = Mac.new
  mac.attr(full_path)
end

def get_mode_block(file_info, full_path)
  "#{get_file_type(file_info)}#{Permission.get_permission(file_info)}#{get_mac_extended_attributes(full_path)}"
end

def get_owner_name(file_info)
  Etc.getpwuid(file_info.uid).name
end

def get_group_name(file_info)
  Etc.getgrgid(file_info.gid).name
end

def recent?(file_mtime)
  return false if file_mtime > Time.now
  six_month = 60 * 60 * 24 * 365.2425 / 2
  file_mtime.to_f >= Time.now.to_f - six_month
end

def get_time_or_year(file_mtime)
  if recent?(file_mtime)
    format '%02d:%02d', file_mtime.hour, file_mtime.min
  else
    format '%5d', file_mtime.year
  end
end

def get_time_stamp(file_mtime)
  month = format '%2d', file_mtime.month
  day = format '%2d', file_mtime.day
  time_or_year = get_time_or_year(file_mtime)
  "#{month} #{day} #{time_or_year}"
end

def get_long_format_line_info(filename, file_info, full_path)
  {
    filename: filename,
    mode_block: get_mode_block(file_info, full_path),
    nlink: file_info.nlink,
    owner_name: get_owner_name(file_info),
    group_name: get_group_name(file_info),
    size: file_info.size,
    time_stamp: get_time_stamp(file_info.mtime),
    blocks: file_info.blocks
  }
end
