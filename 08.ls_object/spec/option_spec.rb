# frozen_string_literal: false

require 'spec_helper'

RSpec.describe Option do # rubocop:disable Metrics/BlockLength
  describe 'reverse?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        argv = []
        expect(Option.new(argv: argv).reverse?).to be_falsy
      end
    end

    context 'when command line argument is "-r"' do
      it 'returns true' do
        argv = ['-r']
        expect(Option.new(argv: argv).reverse?).to be_truthy
      end
    end

    context 'when command line argument is "-la"' do
      it 'returns false' do
        argv = ['-la']
        expect(Option.new(argv: argv).reverse?).to be_falsy
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        argv = ['-lra']
        expect(Option.new(argv: argv).reverse?).to be_truthy
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        argv = ['-r']
        expect(Option.new(argv: argv).reverse?).to be_truthy
      end
    end
  end

  describe 'all?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        argv = []
        expect(Option.new(argv: argv).all?).to be_falsy
      end
    end

    context 'when command line argument is "-a"' do
      it 'returns true' do
        argv = ['-a']
        expect(Option.new(argv: argv).all?).to be_truthy
      end
    end

    context 'when command line argument is "-lr"' do
      it 'returns false' do
        argv = ['-lr']
        expect(Option.new(argv: argv).all?).to be_falsy
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        argv = ['-lra']
        expect(Option.new(argv: argv).all?).to be_truthy
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        argv = ['-l -r -a']
        expect(Option.new(argv: argv).all?).to be_truthy
      end
    end
  end

  describe 'long_format?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        argv = []
        expect(Option.new(argv: argv).long_format?).to be_falsy
      end
    end

    context 'when command line argument is "-l"' do
      it 'returns true' do
        argv = ['-l']
        expect(Option.new(argv: argv).long_format?).to be_truthy
      end
    end

    context 'when command line argument is "-ar"' do
      it 'returns false' do
        argv = ['-ar']
        expect(Option.new(argv: argv).long_format?).to be_falsy
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        argv = ['-lra']
        expect(Option.new(argv: argv).long_format?).to be_truthy
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        argv = ['-l -r -a']
        expect(Option.new(argv: argv).long_format?).to be_truthy
      end
    end
  end
end
