require 'io/console'
require_relative './long_format'

def count_multibyte_chars(str)
  str.chars.reject(&:ascii_only?).length
end

def strlen_multibyte(str)
  str.length + count_multibyte_chars(str) * 2
end

def get_width_for_elem(filenames)
  filenames.map{ |filename| strlen_multibyte(filename) }.max + 1
end

def make_normal_dir_block(filenames)
  return '' if filenames.size <= 0
  width_for_elem = get_width_for_elem(filenames)
  elems_num_per_line = IO.console.winsize[1] / width_for_elem
  rows_num = (filenames.size / elems_num_per_line.to_f).ceil
  str = ''
  (0...rows_num).each do |current_row|
    current_row.step(filenames.size - 1, rows_num) do |i|
      str << format('%-*s', width_for_elem - count_multibyte_chars(filenames[i]), filenames[i])
    end
    str.rstrip! << "\n"
  end
  str
end

def init_long_format_line_infos(filenames)
  long_format_line_infos = []
  filenames.each do |filename|
    p filename
    p File.lstat(filename)
    long_format_line_infos << get_long_format_line_info(filename, File.lstat(filename))
  end
  long_format_line_infos
end

def count_digits(num)
  Math.log10(num.abs).to_i + 1 rescue 1
end

def init_widths(long_format_line_infos)
  nlink_width = long_format_line_infos.map { |info| count_digits(info[:nlink]) }.max
  owner_name_width = long_format_line_infos.map { |info| info[:owner_name].length }.max
  group_name_width = long_format_line_infos.map { |info| info[:group_name].length }.max
  size_width = long_format_line_infos.map { |info| count_digits(info[:size]) }.max
  { nlink: nlink_width, owner_name: owner_name_width, group_name: group_name_width, size: size_width}
end

def make_long_format_line(info, widths)
  nlink_block = format '%*d', widths[:nlink], info[:nlink]
  owner_name_block = format '%-*s', widths[:owner_name], info[:owner_name]
  group_name_block = format '%-*s', widths[:group_name], info[:group_name]
  size_block = format '%*d', widths[:size], info[:size]
  "#{info[:mode_block]} #{nlink_block} #{owner_name_block}  #{group_name_block}  #{size_block} #{info[:time_stamp]} #{info[:filename]}\n"
end

def make_total_blocks_line(total_blocks)
  "total #{total_blocks}\n"
end

def make_long_format_block(filenames)
  long_format_line_infos = init_long_format_line_infos(filenames)
  widths = init_widths(long_format_line_infos)
  str = ''
  # TODO: inject にできないか試す
  long_format_line_infos.each do |info|
    str << make_long_format_line(info, widths)
  end
  str
end

# TODO: 改変後
def make_long_format_dir_block(filenames)
  return '' if filenames.size <= 0
  long_format_block = make_long_format_block(filenames)
  long_format_line_infos = init_long_format_line_infos(filenames)
  total_blocks = long_format_line_infos.map { |info| info[:blocks] }.sum
  "#{make_total_blocks_line(total_blocks)}#{long_format_block}"
end

def make_dir_block_header_line(dir_path)
  "#{dir_path}:\n"
end

def make_dir_block(filenames, dir_path, long_format)
  dir_block = long_format ? make_long_format_dir_block(filenames) : make_normal_dir_block(filenames)
  ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block}" : dir_block
end
