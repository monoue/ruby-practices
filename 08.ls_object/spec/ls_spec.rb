# frozen_string_literal: false

require 'spec_helper'
require 'open3'

RSpec.describe Ls do # rubocop:disable Metrics/BlockLength
  describe 'result' do # rubocop:disable Metrics/BlockLength
    context 'without arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        argv = []
        expect("#{Ls.new(argv: argv).result.split(' ').join("\n")}\n").to eq `ls`
      end
    end

    context 'with option -l' do
      it 'outputs the same result as the output of ls command with the condition' do
        argv = ['-l']
        expect(Ls.new(argv: argv).result).to eq `ls -l`
      end
    end

    context 'with option -lra' do
      it 'outputs the same result as the output of ls command with the condition' do
        argv = ['-lra']
        expect(Ls.new(argv: argv).result).to eq `ls -lra`
      end
    end

    context 'with option -lra and directories for command line arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        argv = ['-lra', 'spec', 'lib']
        expect(Ls.new(argv: argv).result).to eq `ls -lra spec lib`
      end
    end

    context 'with option -lra, files, directories and non-existent paths for command line arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        argv = ['-lra', 'Gemfile', 'Gemfile.lock', 'spec', 'lib', 'hoge', 'fuga']
        cmd = 'ls -lra Gemfile Gemfile.lock spec lib hoge fuga'
        stdout, stderr, = Open3.capture3(cmd)
        expect(Ls.new(argv: argv).body_section).to eq stdout
        expect("#{Ls.new(argv: argv).non_existent_paths_section}\n").to eq stderr
      end
    end
  end
end
