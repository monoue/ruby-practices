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
          LongFormatFilesSection.new(filenames, directory_path: directory_path).format_section(display_total: true)
        else
          NormalFormatFilesSection.new(filenames, directory_path: directory_path).format_section
        end
      ls_option.filenames.size > 1 ? "#{directory_path}:\n#{directory_section}" : directory_section
    end

    private

    attr_reader :directory_path, :ls_option

    def init_filenames(directory_path, ls_option)
      filenames =
        if ls_option.all?
          Dir.glob('*', File::FNM_DOTMATCH, base: directory_path)
        else
          Dir.glob('*', base: directory_path)
        end
      ls_option.reverse? ? filenames.reverse : filenames
    end
  end
end
