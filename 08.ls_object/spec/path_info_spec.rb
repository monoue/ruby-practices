#  frozen_string_literal: false

require 'spec_helper'

RSpec.describe PathInfo do #  rubocop:disable Metrics/BlockLength
  describe 'files' do #  rubocop:disable Metrics/BlockLength
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          expect(PathInfo.new(reverse_flag: false, argv: []).files).to eq []
        end
      end

      context 'when command line argument is a file' do
        it 'returns an array containing the file' do
          expect(PathInfo.new(reverse_flag: false, argv: %w[Gemfile]).files).to eq %w[Gemfile]
        end
      end

      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns an array containing only the files which are sorted' do
          argv = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(PathInfo.new(reverse_flag: false, argv: argv).files).to eq %w[Gemfile Gemfile.lock]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns an array containing only the files which are sorted reversely' do
          argv = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(PathInfo.new(reverse_flag: true, argv: argv).files).to eq %w[Gemfile.lock Gemfile]
        end
      end
    end
  end

  describe 'directories' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns ["."] to point to the current directory' do
          expect(PathInfo.new(reverse_flag: false, argv: []).directories).to eq %w[.]
        end
      end

      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns an array containing only the directories which are sorted' do
          argv = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(PathInfo.new(reverse_flag: false, argv: argv).directories).to eq %w[lib spec]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns the array containg only the directories which are sorted reversely' do
          argv = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(PathInfo.new(reverse_flag: true, argv: argv).directories).to eq %w[spec lib]
        end
      end
    end
  end

  describe 'paths_not_exist' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          expect(PathInfo.new(reverse_flag: false, argv: []).non_existent_paths).to eq []
        end
      end

      context 'when command line arguments include files, directories and non-existent paths' do
        it "returns the array ['fuga', 'hoge']" do
          argv = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(PathInfo.new(reverse_flag: false, argv: argv).non_existent_paths).to eq %w[fuga hoge]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns the array containing only the non-existent paths' do
          ARGV = %w[Gemfile Gemfile.lock lib spec hoge fuga] # rubocop:disable all
          expect(PathInfo.new(reverse_flag: false).non_existent_paths).to eq %w[fuga hoge]
        end
      end
    end
  end
end
