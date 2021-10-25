# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Option do # rubocop:disable Metrics/BlockLength
  describe 'reverse?' do
    context 'without command line arguments' do
      it 'returns false' do
        expect(Option.new.reverse?).to eq false
      end
    end

    context 'when command line argument is "-r"' do
      it 'returns true' do
        ARGV = ['-r']
        expect(Option.new.reverse?).to eq true
      end
    end

    context 'when command line argument is "-la"' do
      it 'returns false' do
        ARGV = ['-la']
        expect(Option.new.reverse?).to eq false
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        ARGV = ['-lra']
        expect(Option.new.reverse?).to eq true
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        ARGV = ['-r']
        expect(Option.new.reverse?).to eq true
      end
    end
  end

  describe 'all?' do
    context 'without command line arguments' do
      it 'returns false' do
        expect(Option.new.all?).to eq false
      end
    end

    context 'when command line argument is "-a"' do
      it 'returns true' do
        ARGV = ['-a']
        expect(Option.new.all?).to eq true
      end
    end

    context 'when command line argument is "-lr"' do
      it 'returns false' do
        ARGV = ['-lr']
        expect(Option.new.all?).to eq false
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        ARGV = ['-lra']
        expect(Option.new.all?).to eq true
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        ARGV = ['-l -r -a']
        expect(Option.new.all?).to eq true
      end
    end
  end

  describe 'long_format?' do
    context 'without command line arguments' do
      it 'returns false' do
        expect(Option.new.long_format?).to eq false
      end
    end

    context 'when command line argument is "-l"' do
      it 'returns true' do
        ARGV = ['-l']
        expect(Option.new.long_format?).to eq true
      end
    end

    context 'when command line argument is "-ar"' do
      it 'returns false' do
        ARGV = ['-ar']
        expect(Option.new.long_format?).to eq false
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        ARGV = ['-lra']
        expect(Option.new.long_format?).to eq true
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        ARGV = ['-l -r -a']
        expect(Option.new.long_format?).to eq true
      end
    end
  end
end
