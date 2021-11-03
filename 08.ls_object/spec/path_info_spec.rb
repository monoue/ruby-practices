#  frozen_string_literal: false

require 'spec_helper'

RSpec.describe PathInfo do #  rubocop:disable Metrics/BlockLength
  describe 'files' do #  rubocop:disable Metrics/BlockLength
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          ARGV = [] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).files).to eq []
        end
      end

      context 'when command line argument is a file' do
        it 'returns an array containing the file' do
          ARGV = %w[Gemfile] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).files).to eq %w[Gemfile]
        end
      end

      context 'when command line arguments include files, directories and non existing paths' do
        it 'returns an array containing only the files which are sorted' do
          ARGV = %w[Gemfile Gemfile.lock lib spec hoge fuga] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).files).to eq %w[Gemfile Gemfile.lock]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non existing paths' do
        it 'returns an array containing only the files which are sorted reversely' do
          ARGV = %w[Gemfile Gemfile.lock lib spec hoge fuga] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: true).files).to eq %w[Gemfile.lock Gemfile]
        end
      end
    end
  end

  describe 'directories' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns ["."] to point to the current directory' do
          ARGV = [] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).directories).to eq %w[.]
        end
      end

      context 'when command line arguments include files, directories and non existing paths' do
        it 'returns an array containing only the directories which are sorted' do
          ARGV = %w[Gemfile Gemfile.lock lib spec hoge fuga] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).directories).to eq %w[lib spec]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non existing paths' do
        it 'returns the array containg only the directories which are sorted reversely' do
          ARGV = %w[Gemfile Gemfile.lock lib spec hoge fuga] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: true).directories).to eq %w[spec lib]
        end
      end
    end
  end

  describe 'paths_not_exist' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          ARGV = [] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).paths_not_exist).to eq []
        end
      end

      context 'when command line arguments include files, directories and non existing paths' do
        it "returns the array ['fuga', 'hoge']" do
          ARGV = %w[Gemfile Gemfile.lock lib spec hoge fuga] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).paths_not_exist).to eq %w[fuga hoge]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non existing paths' do
        it "returns the array ['fuga', 'hoge']" do
          ARGV = %w[Gemfile Gemfile.lock lib spec hoge fuga] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).paths_not_exist).to eq %w[fuga hoge]
        end
      end
    end
  end
end
