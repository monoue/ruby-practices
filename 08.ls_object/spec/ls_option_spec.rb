# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LsOption do # rubocop:disable Metrics/BlockLength
  describe 'reverse?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        command_line_arguments = []
        expect(LsOption.new(command_line_arguments).reverse?).to be_falsy
      end
    end

    context 'when command line argument is "-r"' do
      it 'returns true' do
        command_line_arguments = %w[-r]
        expect(LsOption.new(command_line_arguments).reverse?).to be_truthy
      end
    end

    context 'when command line argument is "-la"' do
      it 'returns false' do
        command_line_arguments = %w[-la]
        expect(LsOption.new(command_line_arguments).reverse?).to be_falsy
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        command_line_arguments = %w[-lra]
        expect(LsOption.new(command_line_arguments).reverse?).to be_truthy
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        command_line_arguments = %w[-r]
        expect(LsOption.new(command_line_arguments).reverse?).to be_truthy
      end
    end
  end

  describe 'all?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        command_line_arguments = []
        expect(LsOption.new(command_line_arguments).all?).to be_falsy
      end
    end

    context 'when command line argument is "-a"' do
      it 'returns true' do
        command_line_arguments = %w[-a]
        expect(LsOption.new(command_line_arguments).all?).to be_truthy
      end
    end

    context 'when command line argument is "-lr"' do
      it 'returns false' do
        command_line_arguments = %w[-lr]
        expect(LsOption.new(command_line_arguments).all?).to be_falsy
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        command_line_arguments = %w[-lra]
        expect(LsOption.new(command_line_arguments).all?).to be_truthy
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        command_line_arguments = %w[-l -r -a]
        expect(LsOption.new(command_line_arguments).all?).to be_truthy
      end
    end
  end

  describe 'long_format?' do # rubocop:disable Metrics/BlockLength
    context 'without command line arguments' do
      it 'returns false' do
        command_line_arguments = []
        expect(LsOption.new(command_line_arguments).long_format?).to be_falsy
      end
    end

    context 'when command line argument is "-l"' do
      it 'returns true' do
        command_line_arguments = %w[-l]
        expect(LsOption.new(command_line_arguments).long_format?).to be_truthy
      end
    end

    context 'when command line argument is "-ar"' do
      it 'returns false' do
        command_line_arguments = %w[-ar]
        expect(LsOption.new(command_line_arguments).long_format?).to be_falsy
      end
    end

    context 'when command line argument is "-lra"' do
      it 'returns true' do
        command_line_arguments = %w[-lra]
        expect(LsOption.new(command_line_arguments).long_format?).to be_truthy
      end
    end

    context 'when command line argument is "-l -r -a"' do
      it 'returns true' do
        command_line_arguments = %w[-l -r -a]
        expect(LsOption.new(command_line_arguments).long_format?).to be_truthy
      end
    end
  end
end
