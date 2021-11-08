# frozen_string_literal: true

class GroupedFilenamesContainer
  attr_reader :files, :directories, :non_existent_paths

  # filenames のデフォルト値は
  def initialize(reverse_flag:, filenames: ARGV)
    @filenames = filenames
    @files = []
    @directories = []
    @non_existent_paths = []
    classify_and_sort_paths(reverse_flag)
  end

  private

  attr_reader :filenames

  def classify_and_sort_paths(reverse_flag)
    classify_paths
    sort_classified_paths(reverse_flag)
  end

  def classify_paths
    if filenames.empty?
      directories << '.'
      return
    end

    filenames.each do |path|
      if File.file?(path)
        files << path
      elsif File.directory?(path)
        directories << path
      else
        non_existent_paths << path
      end
    end
  end

  def sort_classified_paths(reverse_flag)
    files.sort!
    directories.sort!
    non_existent_paths.sort!
    return unless reverse_flag

    files.reverse!
    directories.reverse!
  end
end
