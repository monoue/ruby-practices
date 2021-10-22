# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Frame do
  describe 'score' do
    context "when two arguments('5', '3') given" do
      it 'returns 8' do
        expect(Frame.new('5', '3').score).to eq 8
      end
    end
  end
end
