# frozen_string_literal: true

module Sections
  module LongFormats
    class EntireFileStatusWidth
      attr_reader :nlink, :owner_name, :group_name, :size

      def initialize(file_statuses)
        @nlink, @owner_name, @group_name, @size = search_max_width(file_statuses)
      end

      def search_max_width(file_statuses)
        max_nlink_width = 0
        max_owner_name_width = 0
        max_group_name_width = 0
        max_size_width = 0
        file_statuses.each do |file_status|
          max_nlink_width = [file_status.nlink.to_s.size, max_nlink_width].max
          max_owner_name_width = [file_status.owner_name.size, max_owner_name_width].max
          max_group_name_width = [file_status.group_name.size, max_group_name_width].max
          max_size_width = [file_status.file_size.to_s.size, max_size_width].max
        end
        [max_nlink_width, max_owner_name_width, max_group_name_width, max_size_width]
      end
    end
  end
end
