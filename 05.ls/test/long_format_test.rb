require 'minitest/autorun'
require_relative '../long_format'

class TestLongFormatFileType < Minitest::Test
  def test_long_format_regular_file
    file_info = File.lstat('/bin/cat')
    assert_equal '-', get_file_type(file_info)
  end

  def test_long_format_directory
    file_info = File.lstat('/bin')
    assert_equal 'd', get_file_type(file_info)
  end
end

class TestLongFormatPermission < Minitest::Test
  def test_permission1
    file_info = File.lstat('/iSCSI')
    assert_equal 'rwxrwxrwt', Permission.get_permission(file_info)
  end

  def test_permission2
    file_info = File.lstat('/Applications')
    assert_equal 'rwxrwxr-x', Permission.get_permission(file_info)
  end

  def test_permission3
    file_info = File.lstat('/goinfre')
    assert_equal 'rwxrwxrwt', Permission.get_permission(file_info)
  end

  def test_permission4
    file_info = File.lstat('/dev')
    assert_equal 'r-xr-xr-x', Permission.get_permission(file_info)
  end

  def test_permission5
    file_info = File.lstat('/sgoinfre')
    assert_equal 'r-xr-xr-x', Permission.get_permission(file_info)
  end
end

class TestUserName < Minitest::Test
  def test_user_name1
    file_info = File.lstat('/iSCSI')
    assert_equal 'root', get_user_name(file_info)
  end

  def test_user_name2
    file_info = File.lstat('/exam')
    assert_equal 'exam', get_user_name(file_info)
  end
end

class TestGroupName < Minitest::Test
  def test_group_name1
    file_info = File.lstat('/iSCSI')
    assert_equal 'wheel', get_group_name(file_info)
  end

  def test_group_name2
    file_info = File.lstat('/exam')
    assert_equal 'applications', get_group_name(file_info)
  end
end

class TestFileSize < Minitest::Test
  def test_file_size1
    file_info = File.lstat('/iSCSI')
    assert_equal 64, file_info.size
  end

  def test_group_name2
    file_info = File.lstat('/exam')
    assert_equal 576, file_info.size
  end
end

class TestModificationTime < Minitest::Test
  def test_mtime1
    file_info = File.lstat('/iSCSI')
    assert_equal ' 1  6  2020', get_time_stamp(file_info.mtime)
  end

  def test_mtime2
    file_info = File.lstat('/Applications')
    assert_equal ' 4 19 14:59', get_time_stamp(file_info.mtime)
  end
end


