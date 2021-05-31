require 'minitest/autorun'
require_relative '../long_format'

class TestLongFormat < Minitest::Test
  def test_long_format_regular_file
    file_info = File.lstat('/bin/cat')
    assert_equal '-', get_file_type(file_info)
  end

  def test_long_format_directory
    file_info = File.lstat('/bin')
    assert_equal 'd', get_file_type(file_info)
  end
end