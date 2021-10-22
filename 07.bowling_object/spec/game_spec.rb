# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Game do
  describe 'result' do
    context "when input is (6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5)" do
      it 'returns 139' do
        expect(Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5').result).to eq 139
      end
    end

    context "when input is (6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X)" do
      it 'returns 164' do
        expect(Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X').result).to eq 164
      end
    end

    context "when input is (0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4)" do
      it 'returns 107' do
        expect(Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4').result).to eq 107
      end
    end

    context "when input is (6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0)" do
      it 'returns 134' do
        expect(Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0').result).to eq 134
      end
    end

    context "when input is (X,X,X,X,X,X,X,X,X,X,X,X)" do
      it 'returns 300' do
        expect(Game.new('X,X,X,X,X,X,X,X,X,X,X,X').result).to eq 300
      end
    end
  end
end
