# frozen_string_literal: false

require 'spec_helper'

RSpec.describe Option do # rubocop:disable Metrics/BlockLength
  describe 'reverse?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        expect(Option.new.reverse?).to eq false
      end
    end

    context 'when command line argument is "-r"' do
      it 'returns true' do
        ARGV = ['-r'] # rubocop:disable all
        expect(Option.new.reverse?).to eq true
      end
    end

    context 'when command line argument is "-la"' do
      it 'returns false' do
        ARGV = ['-la'] # rubocop:disable all
        expect(Option.new.reverse?).to eq false
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        ARGV = ['-lra'] # rubocop:disable all
        expect(Option.new.reverse?).to eq true
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        ARGV = ['-r'] # rubocop:disable all
        expect(Option.new.reverse?).to eq true
      end
    end
  end

  describe 'all?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        expect(Option.new.all?).to eq false
      end
    end

    context 'when command line argument is "-a"' do
      it 'returns true' do
        ARGV = ['-a'] # rubocop:disable all
        expect(Option.new.all?).to eq true
      end
    end

    context 'when command line argument is "-lr"' do
      it 'returns false' do
        ARGV = ['-lr'] # rubocop:disable all
        expect(Option.new.all?).to eq false
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        ARGV = ['-lra'] # rubocop:disable all
        expect(Option.new.all?).to eq true
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        ARGV = ['-l -r -a'] # rubocop:disable all
        expect(Option.new.all?).to eq true
      end
    end
  end

  describe 'long_format?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        expect(Option.new.long_format?).to eq false
      end
    end

    context 'when command line argument is "-l"' do
      it 'returns true' do
        ARGV = ['-l'] # rubocop:disable all
        expect(Option.new.long_format?).to eq true
      end
    end

    context 'when command line argument is "-ar"' do
      it 'returns false' do
        ARGV = ['-ar'] # rubocop:disable all
        expect(Option.new.long_format?).to eq false
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        ARGV = ['-lra'] # rubocop:disable all
        expect(Option.new.long_format?).to eq true
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        ARGV = ['-l -r -a'] # rubocop:disable all
        expect(Option.new.long_format?).to eq true
      end
    end
  end
end
