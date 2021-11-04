# frozen_string_literal: true

class Permission
  def initialize(file_info)
    @file_info = file_info
  end

  def text
    mode_octal = file_info.mode.to_s(8)
    permission_strs = {}
    permission_strs[:owner] = get_owner_or_group_permission(mode_octal[-3].to_i.to_s(2), file_info.setuid?)
    permission_strs[:group] = get_owner_or_group_permission(mode_octal[-2].to_i.to_s(2), file_info.setgid?)
    permission_strs[:other] = get_other_permission(mode_octal[-1].to_i.to_s(2), file_info.sticky?)
    permission_strs.values.join
  end

  private

  attr_reader :file_info

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
