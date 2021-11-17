# frozen_string_literal: true

require_relative './normal_format_files_section'
require_relative './long_format_files_section'

module Sections
  class DirectorySection
    def initialize(directory_path:, ls_option:)
      @directory_path = directory_path
      @ls_option = ls_option
    end

    def to_s
      filenames = init_filenames(directory_path, ls_option)
      directory_section = if ls_option.long_format?
                            make_total_blocks_line(filenames) +
                              LongFormatFilesSection.new(filenames: filenames, directory_path: directory_path).to_s
                          else
                            NormalFormatFilesSection.new(filenames: filenames, directory_path: directory_path).to_s
                          end
      ls_option.filenames.size > 1 ? "#{header_line(directory_path)}#{directory_section}" : directory_section
    end

    private

    attr_reader :directory_path, :ls_option

    def make_total_blocks_line(filenames)
      file_statuses = filenames.map { |filename| FileStatus.new(filename: filename, directory_path: directory_path) }
      total_blocks = file_statuses.map(&:blocks).sum
      "total #{total_blocks}\n"
    end

    def header_line(directory_path)
      "#{directory_path}:\n"
    end

    def init_filenames(directory_path, option)
      filenames = Dir.entries(directory_path)
      filenames = filenames.reject { |filename| filename[0] == '.' } unless option.all?
      filenames.sort!
      option.reverse? ? filenames.reverse : filenames
    end
  end
end
