require 'io/console'

def get_width_for_elem(filenames)
  max_filename_len = 0
  filenames.each do |filename|
    max_filename_len = filename.length if max_filename_len < filename.length
  end
  max_filename_len + 1
end

def make_directory_block(dir_name, options)
  filenames = Dir.entries(dir_name)
  filenames = filenames.reject { |filename| filename[0] == '.' } unless options[:all]
  filenames.sort!
  filenames.reverse! if options[:reverse]
  width_for_elem = get_width_for_elem(filenames)
  elems_num_per_line = IO.console.winsize[1] / width_for_elem
  rows_num = (filenames.size / elems_num_per_line.to_f).ceil
  str = ''
  (0...rows_num).each do |current_row|
    current_row.step(filenames.size, rows_num) do |i|
      str << format('%-*s', width_for_elem, filenames[i])
    end
    str.rstrip! << "\n"
  end
  str
end

# print make_directory_block('/', {reverse: true})