# frozen_string_literal: true

require_relative './long_format_directory_section'
require_relative './normal_format_files_section'

class DirectorySection
  def initialize(directory_path:, ls_option:)
    @directory_path = directory_path
    @ls_option = ls_option
  end

  def to_s
    filenames = init_filenames(directory_path, ls_option)
    directory_block_str = if ls_option.long_format?
                            LongFormatDirectorySection.new(filenames: filenames,
                                                           directory_path: directory_path).to_s
                          else
                            NormalFormatFilesSection.new(filenames).to_s
                          end
    ls_option.filenames.size > 1 ? "#{header_line(directory_path)}#{directory_block_str}" : directory_block_str
  end

  private

  attr_reader :directory_path, :ls_option

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
