class PathInfo
  attr_reader :files, :directories, :paths_not_exist

  def initialize(reverse_flag)
    @files = []
    @directories = []
    @paths_not_exist = []
    classify_and_sort_paths(reverse_flag)
  end

  private

  def classify_and_sort_paths(reverse_flag)
    classify_paths
    sort_classified_paths(reverse_flag)
  end

  def classify_paths
    if ARGV.empty?
      directories << '.'
      return
    end

    ARGV.each do |path|
      if File.file?(path)
        files << path
      elsif File.directory?(path)
        directories << path
      else
        paths_not_exist << path
      end
    end
  end

  def sort_classified_paths(reverse_flag)
    files.sort!
    directories.sort!
    paths_not_exist.sort!
    return unless reverse_flag

    files.reverse!
    directories.reverse!
  end
end
