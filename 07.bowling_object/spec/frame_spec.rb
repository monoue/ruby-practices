# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Frame do
  describe 'score' do
    context "strike" do
      context "when two arguments('X', '3', '5') given" do
        it 'returns 18' do
          expect(Frame.new('X', '5', '3').score).to eq 18
        end
      end
    end

    context "spare" do
      context "when two arguments('4', '6', '7') given" do
        it 'returns 17' do
          expect(Frame.new('4', '6', '7').score).to eq 17
        end
      end
    end

    context "last frame" do
      context "when two arguments('5', '3') given" do
        it 'returns 8' do
          expect(Frame.new('5', '3', nil).score).to eq 8
        end
      end
    end

    context "not strike or spare or last frame" do
      context "when three arguments('5', '3', '8') given" do
        it 'returns 8' do
          expect(Frame.new('5', '3', '8').score).to eq 8
        end
      end
    end
  end
end
