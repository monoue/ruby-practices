require 'spec_helper'

RSpec.describe Frame do
  describe 'score' do
    context "when two arguments('5', 'X') given" do
      it 'returns 15' do
        expect(Frame.new('5', 'X').score).to eq 15
      end
    end
  end
end
