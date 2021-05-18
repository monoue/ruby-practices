def str_is_integer?(str)
  str =~ /\A[0-9]+\z/
end

def is_valid_month?(var)
  str_is_integer?(var) && var.to_i.between?(1, 12)
end

def is_valid_year?(var)
  str_is_integer?(var) && var.to_i.between?(1, 9999)
end
