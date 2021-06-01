require 'minitest/autorun'
require_relative '../make_directory_block'

CASE = <<'TEXT'
long_format.rb          make_directory_block.rb test
TEXT

class TestLongFormatFileType < Minitest::Test
  def test_long_format_regular_file
    file_info = File.lstat('/bin/cat')
    assert_equal CASE.chomp, make_directory_block('.', {})
  end


  def test_long_format_directory
    root = 'Applications              Network                   System                    '\
'Volumes                   cores                     etc                       goinfre                   '\
'iSCSI                     net                       private                   sgoinfre                  '\
'usr                       Library                   Previous Content          Users                     '\
'bin                       dev                       exam                      home                      '\
'installer.failurerequests nfs                       sbin                      tmp                       var'
    file_info = File.lstat('/')
    assert_equal root, make_directory_block('/', {})
  end
end

