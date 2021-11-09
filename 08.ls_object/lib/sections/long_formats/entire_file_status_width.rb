# frozen_string_literal: true

module Sections
  module LongFormats
    class EntireFileStatusWidth
      def initialize(file_statuses)
        @file_statuses = file_statuses
      end

      def nlink
        get_status_max_width(proc { |file_status| file_status.nlink.to_s })
      end

      def owner_name
        get_status_max_width(proc { |file_status| file_status.owner_name })
      end

      def group_name
        get_status_max_width(proc { |file_status| file_status.group_name })
      end

      def size
        get_status_max_width(proc { |file_status| file_status.file_size.to_s })
      end

      private

      attr_reader :file_statuses

      def get_status_max_width(method)
        file_statuses.map { |file_status| method.call(file_status).size }.max
      end
    end
  end
end
