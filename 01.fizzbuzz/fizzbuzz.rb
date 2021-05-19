#!/usr/bin/env ruby
# frozen_string_literal: true

def make_fizzbuzz_applied_elem(num)
  if (num % 15).zero? then :FizzBuzz
  elsif (num % 5).zero? then :Buzz
  elsif (num % 3).zero? then :Fizz
  else num
  end
end

def make_output_str
  str = ''
  (1..20).each { |num| str.concat "#{make_fizzbuzz_applied_elem(num)}\n" }
  str
end

print make_output_str
