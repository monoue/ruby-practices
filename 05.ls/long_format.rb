file_info = File.lstat('/bin/cat')
def get_file_type(file_info)
  case file_info.ftype
  when 'blockSpecial'
    'b'
  when 'characterSpecial'
    'c'
  when 'directory'
    'd'
  when 'link'
    'l'
  when 'socket'
    's'
  when 'fifo'
    'p'
  when 'file'
    '-'
  else
    ' '
  end
end

def get_owner_permission(file_info)

end

def get_permission(file_info)
  "#{get_owner_permission(file_info)}#{get_group_permission(file_info)}#{get_other_permission(file_info)}"
end