# frozen_string_literal: true

class GroupedFilenamesContainer
  attr_reader :files, :directories, :non_existent_paths

  def initialize(filenames, reverse_flag:)
    classified_paths = classify_paths(filenames)
    @files, @directories, @non_existent_paths = sort_paths(classified_paths, reverse_flag)
  end

  private

  def classify_paths(filenames)
    paths = { files: [], directories: [], non_existent_paths: [] }
    if filenames.empty?
      paths[:directories] << '.'
    else
      filenames.each do |path|
        if File.file?(path)
          paths[:files] << path
        elsif File.directory?(path)
          paths[:directories] << path
        else
          paths[:non_existent_paths] << path
        end
      end
    end
    paths
  end

  def sort_paths(paths, reverse_flag)
    sorted_paths = paths.transform_values(&:sort)
    if reverse_flag
      [sorted_paths[:files].reverse, sorted_paths[:directories].reverse, sorted_paths[:non_existent_paths]]
    else
      sorted_paths.values
    end
  end
end
