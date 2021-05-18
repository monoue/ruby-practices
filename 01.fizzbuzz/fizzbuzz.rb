#!/usr/bin/env ruby

def make_fizzbuzz_applied_elem(num)
  if (num % 15).zero? then :FizzBuzz
  elsif (num % 5).zero? then :Buzz
  elsif (num % 3).zero? then :Fizz
  else num
  end
end

def make_fizzbuzz_applied_line(num)
  "#{make_fizzbuzz_applied_elem(num)}\n"
end

def make_output_str
  str = ''
  (1..20).each { |num| str << make_fizzbuzz_applied_line(num) }
  str
end

print make_output_str
