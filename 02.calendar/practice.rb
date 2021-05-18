require 'optparse'
opt = OptionParser.new

opt.on('-y ')
opt.on('-m')

opt.parse!(ARGV)
p ARGV

# ruby sample.rb -a foo bar -b baz
# # => true
#      true
#      ["foo", "bar", "baz"]