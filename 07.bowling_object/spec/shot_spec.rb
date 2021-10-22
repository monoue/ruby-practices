require 'spec_helper'

RSpec.describe Shot do
  describe 'score' do
    context "when mark is 'X'" do
      it "returns 10" do
        expect(Shot.new('X').score).to eq 10
      end
    end

    context "when mark is '5'" do
      it 'returns 5' do
        expect(Shot.new('5').score).to eq 5
      end
    end

    context "when mark is nil" do
      it 'returns 0' do
        expect(Shot.new(nil).score).to eq 0
      end
    end
  end
end
