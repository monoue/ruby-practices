# frozen_string_literal: true

require 'spec_helper'
require 'open3'

RSpec.describe Ls do # rubocop:disable Metrics/BlockLength
  describe 'build_results' do # rubocop:disable Metrics/BlockLength
    def compare_results(command_line_argument)
      command_line_arguments = command_line_argument.split(' ')
      warning_message, normal_result = Ls.new(command_line_arguments: command_line_arguments.dup).build_results
      cmd = ['ls', *command_line_arguments].join(' ')
      stdout, stderr, = Open3.capture3(cmd)
      expect(warning_message).to eq stderr.chomp
      expect(normal_result).to eq stdout
    end

    context 'without arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        warning_message, normal_result = Ls.new(command_line_arguments: []).build_results
        stdout, stderr, = Open3.capture3('ls')
        expect(normal_result.split(' ').join("\n")).to eq stdout.chomp
        expect(warning_message).to eq stderr
      end
    end

    context 'with option "-l"' do
      it 'outputs the same result as the output of ls command with the condition' do
        compare_results('-l')
      end
    end

    context 'with option "-lra"' do
      it 'outputs the same result as the output of ls command with the condition' do
        compare_results('-lra')
      end
    end

    context 'with option "-l -r -a"' do
      it 'outputs the same result as the output of ls command with the condition' do
        compare_results('-l -r -a')
      end
    end

    context 'with option -lra and directories for command line arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        compare_results('-l -r -a spec lib')
      end
    end

    context 'with option -lra, files, directories and non-existent paths for command line arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        compare_results('-lra Gemfile Gemfile.lock spec lib hoge fuga ')
      end
    end
  end
end
