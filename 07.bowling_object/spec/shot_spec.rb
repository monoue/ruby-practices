require 'spec_helper'

RSpec.describe Shot do
  describe 'mark' do
    context "when input is 'X'" do
      it "returns 10" do
        expect(Shot.new('X').mark).to eq 10
      end
    end

    context "when input is '0'" do
      it 'returns 0' do
        expect(Shot.new('0').mark).to eq 0
      end
    end

    context "when input is '5'" do
      it 'returns 5' do
        expect(Shot.new('5').mark).to eq 5
      end
    end
  end
end