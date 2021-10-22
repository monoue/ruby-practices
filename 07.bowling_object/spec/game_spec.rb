require 'spec_helper'

RSpec.describe Game do
  describe 'result' do
    context "when input is (6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5)" do
      it 'returns 139' do
        expect(Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5').result).to eq 139
      end
    end
  end
end
