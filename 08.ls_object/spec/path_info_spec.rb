#  frozen_string_literal: false

require 'spec_helper'

RSpec.describe PathInfo do #  rubocop:disable Metrics/BlockLength
  describe 'files' do #  rubocop:disable Metrics/BlockLength
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          ARGV = [] # rubocop:disable all
          expect(PathInfo.new(false).files).to eq []
        end
      end

      context "when command line argument is 'Gemfile'" do
        it "returns an array including 'Gemfile'" do
          ARGV = ['Gemfile'] # rubocop:disable all
          expect(PathInfo.new(false).files).to eq ['Gemfile']
        end
      end

      context "when command line argument is 'Gemfile' 'Gemfile.lock' 'lib', 'spec', 'hoge', 'fuga'" do
        it "returns the array ['Gemfile', 'Gemfile.lock']" do
          ARGV = ['Gemfile', 'Gemfile.lock', 'lib', 'spec', 'hoge', 'fuga'] # rubocop:disable all
          expect(PathInfo.new(false).files).to eq ['Gemfile', 'Gemfile.lock']
        end
      end
    end

    context 'with reverse flag' do
      context "when command line argument is 'Gemfile' 'Gemfile.lock' 'lib', 'spec', 'hoge', 'fuga'" do
        it "returns the array ['Gemfile.lock', 'Gemfile']" do
          ARGV = ['Gemfile', 'Gemfile.lock', 'lib', 'spec', 'hoge', 'fuga'] # rubocop:disable all
          expect(PathInfo.new(true).files).to eq ['Gemfile.lock', 'Gemfile']
        end
      end
    end
  end

  describe 'directories' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns "."' do
          ARGV = [] # rubocop:disable all
          expect(PathInfo.new(false).directories).to eq ['.']
        end
      end

      context "when command line argument is 'Gemfile' 'Gemfile.lock' 'lib', 'spec', 'hoge', 'fuga'" do
        it "returns the array ['lib', 'spec']" do
          ARGV = ['Gemfile', 'Gemfile.lock', 'lib', 'spec', 'hoge', 'fuga'] # rubocop:disable all
          expect(PathInfo.new(false).directories).to eq %w[lib spec]
        end
      end
    end

    context 'with reverse flag' do
      context "when command line argument is 'Gemfile' 'Gemfile.lock' 'lib', 'spec', 'hoge', 'fuga'" do
        it "returns the array ['spec', 'lib']" do
          ARGV = ['Gemfile', 'Gemfile.lock', 'lib', 'spec', 'hoge', 'fuga'] # rubocop:disable all
          expect(PathInfo.new(true).directories).to eq %w[spec lib]
        end
      end
    end
  end

  describe 'paths_not_exist' do
    context 'without reverse flag' do
      context 'without arguments' do
        it 'returns an empty array' do
          ARGV = [] # rubocop:disable all
          expect(PathInfo.new(false).paths_not_exist).to eq []
        end
      end

      context "when command line argument is 'Gemfile' 'Gemfile.lock' 'lib', 'spec', 'hoge', 'fuga'" do
        it "returns the array ['fuga', 'hoge']" do
          ARGV = ['Gemfile', 'Gemfile.lock', 'lib', 'spec', 'hoge', 'fuga'] # rubocop:disable all
          expect(PathInfo.new(false).paths_not_exist).to eq %w[fuga hoge]
        end
      end
    end

    context 'with reverse flag' do
      context "when command line argument is 'Gemfile' 'Gemfile.lock' 'lib', 'spec', 'hoge', 'fuga'" do
        it "returns the array ['fuga', 'hoge']" do
          ARGV = ['Gemfile', 'Gemfile.lock', 'lib', 'spec', 'hoge', 'fuga'] # rubocop:disable all
          expect(PathInfo.new(false).paths_not_exist).to eq %w[fuga hoge]
        end
      end
    end
  end
end
