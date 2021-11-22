# frozen_string_literal: true

require_relative './normal_format_files_section'
require_relative './long_format_files_section'

module Sections
  class DirectorySection
    def initialize(directory_path, ls_option)
      @directory_path = directory_path
      @ls_option = ls_option
    end

    def format_section
      filenames = init_filenames(directory_path, ls_option)
      directory_section =
        if ls_option.long_format?
          LongFormatFilesSection.new(filenames, directory_path: directory_path, total_blocks: true).format_section
        else
          NormalFormatFilesSection.new(filenames, directory_path: directory_path).format_section
        end
      ls_option.filenames.size > 1 ? "#{directory_path}:\n#{directory_section}" : directory_section
    end

    private

    attr_reader :directory_path, :ls_option

    def init_filenames(directory_path, ls_option)
      # p directory_path
      filenames = Dir.entries(directory_path)
      filenames = filenames.reject { |filename| filename[0] == '.' } unless ls_option.all?
      filenames.sort!
      ls_option.reverse? ? filenames.reverse : filenames
    end
    # def init_filenames(directory_path, ls_option)
      # p "#{directory_path}/*"
      # filenames = ls_option.all? ? Dir.glob("#{directory_path}/*") : Dir.entries(directory_path)
      # filenames = filenames.reject { |filename| filename[0] == '.' } unless ls_option.all?
      # p filenames
      # filenames.sort!
    #   ls_option.reverse? ? filenames.reverse : filenames
    # end
  end
end
