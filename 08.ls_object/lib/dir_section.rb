# class DirSection
#   attr_reader :data
#
#   def initialize(dir_paths)
#     @dir_paths = dir_paths
#     @data = make_data
#     @option = Option.new
#   end
#
#   private
#
#   def make_data
#     return make_dir_block('.') if ARGV.empty?
#   end
#
#   def make_dir_block(dir_path)
#     filenames = init_filenames(dir_path)
#     dir_block = option.long_format? ? LongFormat.make_long_format_dir_block(filenames, dir_path) : NormalFormat.make_normal_dir_block(filenames)
#     ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block}" : dir_block
#   end
#
#   def make_dir_blocks(dir_paths, options)
#     dir_blocks = []
#     dir_paths.each do |dir_path|
#       dir_blocks << make_dir_block(dir_path)
#     end
#     dir_blocks
#   end
#
#   def make_dir_block_header_line(dir_path)
#     "#{dir_path}:\n"
#   end
#
#   def init_filenames(dir_path)
#     filenames = Dir.entries(dir_path)
#     filenames = filenames.reject { |filename| filename[0] == '.' } unless option.all?
#     filenames.sort!
#     option.reverse? ? filenames.reverse : filenames
#   end
#
#   attr_reader :dir_paths, :option
# end
#
# # module DirBlock
# #   class << self
# #     def make_dir_block_header_line(dir_path)
# #       "#{dir_path}:\n"
# #     end
# #
# #     def init_filenames(dir_path, options)
# #       filenames = Dir.entries(dir_path)
# #       filenames = filenames.reject { |filename| filename[0] == '.' } unless options[:all]
# #       filenames.sort!
# #       options[:reverse] ? filenames.reverse : filenames
# #     end
# #   end
# #
# #   private_class_method :make_dir_block_header_line, :init_filenames
# #
# #   class << self
# #     def make_dir_block(dir_path, options)
# #       filenames = init_filenames(dir_path, options)
# #       dir_block = options[:long_format] ? LongFormat.make_long_format_dir_block(filenames, dir_path) : NormalFormat.make_normal_dir_block(filenames)
# #       ARGV.size > 1 ? "#{make_dir_block_header_line(dir_path)}#{dir_block}" : dir_block
# #     end
# #
# #     def make_dir_blocks(dir_paths, options)
# #       dir_blocks = []
# #       dir_paths.each do |dir_path|
# #         dir_blocks << make_dir_block(dir_path, options)
# #       end
# #       dir_blocks
# #     end
# #   end
# # end
