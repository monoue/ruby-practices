# frozen_string_literal: true

module Sections
  module LongFormats
    class EntireFileStatusWidth
      def initialize(file_statuses)
        @file_statuses = file_statuses
      end

      def nlink
        file_statuses.max_by(&:nlink).nlink.to_s.size
      end

      def owner_name
        file_statuses.max_by { |file_status| file_status.owner_name.size }.owner_name.size
      end

      def group_name
        file_statuses.max_by { |file_status| file_status.group_name.size }.group_name.size
      end

      def size
        file_statuses.max_by(&:file_size).file_size.to_s.size
      end

      private

      attr_reader :file_statuses
    end
  end
end
