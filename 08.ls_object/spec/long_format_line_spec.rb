# frozen_string_literal: true

require 'spec_helper'
require 'time'

RSpec.describe Sections::LongFormats::LongFormatLine do # rubocop:disable Metrics/BlockLength
  describe 'format_line' do # rubocop:disable Metrics/BlockLength
    let!(:entire_file_status_width) { Struct.new(:nlink, :owner_name, :group_name, :file_size) }
    let!(:status_width) { entire_file_status_width.new(0, 0, 0, 0) }
    let!(:file_status) { FileStatus.new('spec_helper.rb', directory_path: 'spec') }

    context "when the target file's last modification time is" do # rubocop:disable Metrics/BlockLength
      # 2021-12-15 12:00 の半年前は 2021-06-15 21:05:24

      context 'within half a year ago' do
        it 'includes the hour and the minute of the time' do
          allow(file_status).to receive(:time_stamp).and_return(Time.parse('2021-06-15 21:06'))
          format_line = Sections::LongFormats::LongFormatLine.new(file_status, status_width)
          allow(format_line).to receive(:current_time).and_return(Time.parse('2021-12-15 12:00'))
          expect(format_line.format_line).to include ' 6 15 21:06'
        end
      end

      context 'older than half a year ago' do
        it 'includes the year of the time' do
          allow(file_status).to receive(:time_stamp).and_return(Time.parse('2021-06-15 21:05'))
          format_line = Sections::LongFormats::LongFormatLine.new(file_status, status_width)
          allow(format_line).to receive(:current_time).and_return(Time.parse('2021-12-15 12:00'))
          expect(format_line.format_line).to include ' 6 15  2021'
        end
      end
    end
  end
end
