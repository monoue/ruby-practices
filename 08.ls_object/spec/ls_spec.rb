# frozen_string_literal: true

require 'spec_helper'
require 'open3'

RSpec.describe Ls do # rubocop:disable Metrics/BlockLength
  describe 'build_results' do # rubocop:disable Metrics/BlockLength
    def compare_results(command_line_argument)
      command_line_arguments = command_line_argument.split(' ')
      warning_message, normal_result = Ls.build_results(command_line_arguments.dup)
      cmd = ['ls', *command_line_arguments].join(' ')
      stdout, stderr, _status = Open3.capture3(cmd)
      expect(warning_message).to eq stderr.chomp
      expect("#{normal_result}\n").to eq stdout
    end

    context 'without arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        warning_message, normal_result = Ls.build_results([])
        stdout, stderr, _status = Open3.capture3('ls')
        normal_result_for_stdout = normal_result.split(' ').join("\n")
        expect(normal_result_for_stdout).to eq stdout.chomp
        expect(warning_message).to eq stderr
      end
    end

    context 'with directories arguments' do
      it 'outputs the same result as the output of ls command with the condition' do
        warning_message, normal_result = Ls.build_results(%w[lib spec])
        stdout, stderr, _status = Open3.capture3('ls lib spec')
        raw_sections = normal_result.split("\n\n")
        normal_results_for_stdout = raw_sections.map do |raw_section|
          section_elements = raw_section.split(' ')
          [section_elements[0], *section_elements[1..].sort].join("\n")
        end
        normal_result_for_stdout_without_section_separation = normal_results_for_stdout.join("\n")
        start_of_the_second_section = normal_result_for_stdout_without_section_separation.index('spec:')
        normal_result_for_stdout = normal_result_for_stdout_without_section_separation.insert(start_of_the_second_section, "\n")
        expect(normal_result_for_stdout).to eq stdout.chomp
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
