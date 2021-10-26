#!/usr/bin/env ruby

# frozen_string_literal: true

require './lib/ls'

if __FILE__ == $PROGRAM_NAME # rubocop:disable Style/IfUnlessModifier
  puts Ls.new.result
end
