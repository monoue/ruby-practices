# frozen_string_literal: true

module Sections
  module LongFormats
    class Permission
      def initialize(file_lstat)
        @file_lstat = file_lstat
      end

      def to_s
        mode_octal = file_lstat.mode.to_s(8)
        owner_permission = get_owner_or_group_permission(mode_octal[-3].to_i.to_s(2), file_lstat.setuid?)
        group_permission = get_owner_or_group_permission(mode_octal[-2].to_i.to_s(2), file_lstat.setgid?)
        other_permission = get_other_permission(mode_octal[-1].to_i.to_s(2), file_lstat.sticky?)
        owner_permission + group_permission + other_permission
      end

      private

      attr_reader :file_lstat

      def char_bit_set?(char)
        char == '1'
      end

      def get_readable_and_writable_string(permission_binary_string)
        readable_character = char_bit_set?(permission_binary_string[-3]) ? 'r' : '-'
        writable_character = char_bit_set?(permission_binary_string[-2]) ? 'w' : '-'
        readable_character + writable_character
      end

      def get_executable_or_not_char(permission_binary_character)
        char_bit_set?(permission_binary_character) ? 'x' : '-'
      end

      def get_owner_or_group_permission(permission_binary_string, set_user_or_group_id)
        readable_and_writable_string = get_readable_and_writable_string(permission_binary_string)
        executable_char = if set_user_or_group_id
                            char_bit_set?(permission_binary_string[-1]) ? 's' : 'S'
                          else
                            get_executable_or_not_char(permission_binary_string[-1])
                          end
        readable_and_writable_string + executable_char
      end

      def get_other_permission(permission_binary_string, sticky)
        readable_and_writable_string = get_readable_and_writable_string(permission_binary_string)
        executable_char = if sticky
                            char_bit_set?(permission_binary_string[-1]) ? 't' : 'T'
                          else
                            get_executable_or_not_char(permission_binary_string[-1])
                          end
        readable_and_writable_string + executable_char
      end
    end
  end
end
