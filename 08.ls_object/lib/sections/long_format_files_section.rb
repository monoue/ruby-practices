# frozen_string_literal: false

require_relative './long_formats'

module Sections
  class LongFormatFilesSection
    def initialize(file_statuses)
      @file_statuses = file_statuses
    end

    def to_s
      entire_file_status_width = LongFormats::EntireFileStatusWidth.new(file_statuses)
      file_statuses.map do |file_status|
        LongFormats::LongFormatLine.new(
          file_status: file_status,
          entire_file_status_width: entire_file_status_width
        )
      end.join
    end

    private

    attr_reader :file_statuses
  end
end
