#  frozen_string_literal: false

require 'spec_helper'

RSpec.describe GroupedFilenamesContainer do #  rubocop:disable Metrics/BlockLength
  describe 'files' do #  rubocop:disable Metrics/BlockLength
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: []).files).to eq []
        end
      end

      context 'when command line argument is a file' do
        it 'returns an array containing the file' do
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: %w[Gemfile]).files).to eq %w[Gemfile]
        end
      end

      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns an array containing only the files which are sorted' do
          filenames = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: filenames).files).to eq %w[Gemfile Gemfile.lock]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns an array containing only the files which are sorted reversely' do
          filenames = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(GroupedFilenamesContainer.new(reverse_flag: true, filenames: filenames).files).to eq %w[Gemfile.lock Gemfile]
        end
      end
    end
  end

  describe 'directories' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns ["."] to point to the current directory' do
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: []).directories).to eq %w[.]
        end
      end

      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns an array containing only the directories which are sorted' do
          filenames = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: filenames).directories).to eq %w[lib spec]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns the array containg only the directories which are sorted reversely' do
          filenames = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(GroupedFilenamesContainer.new(reverse_flag: true, filenames: filenames).directories).to eq %w[spec lib]
        end
      end
    end
  end

  describe 'paths_not_exist' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: []).non_existent_paths).to eq []
        end
      end

      context 'when command line arguments include files, directories and non-existent paths' do
        it "returns the array ['fuga', 'hoge']" do
          filenames = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: filenames).non_existent_paths).to eq %w[fuga hoge]
        end
      end
    end

    context 'with reverse flag' do
      context 'when command line arguments include files, directories and non-existent paths' do
        it 'returns the array containing only the non-existent paths' do
          filenames = %w[Gemfile Gemfile.lock lib spec hoge fuga]
          expect(GroupedFilenamesContainer.new(reverse_flag: false, filenames: filenames).non_existent_paths).to eq %w[fuga hoge]
        end
      end
    end
  end
end
