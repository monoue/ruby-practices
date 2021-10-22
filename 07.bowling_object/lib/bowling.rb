#!/usr/bin/env ruby

# frozen_string_literal: true

require './lib/game'

puts Game.new(ARGV[0]).result
