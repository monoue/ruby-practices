# frozen_string_literal: true

require_relative './file_status'
require_relative './long_format_files_section'

class LongFormatDirectorySection
  def initialize(filenames:, directory_path:)
    @filenames = filenames
    @directory_path = directory_path
  end

  def to_s
    return '' if filenames.size <= 0

    long_format_block = LongFormatFilesSection.new(filenames: filenames, directory_path: directory_path)
    long_format_line_infos = filenames.map { |filename| FileStatus.new(filename: filename, directory_path: directory_path) }
    total_blocks = long_format_line_infos.map(&:blocks).sum
    make_total_blocks_line(total_blocks) + long_format_block.to_s
  end

  private

  attr_reader :filenames, :directory_path

  def make_total_blocks_line(total_blocks)
    "total #{total_blocks}\n"
  end
end
