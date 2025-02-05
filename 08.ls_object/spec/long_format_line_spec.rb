# frozen_string_literal: true

require 'spec_helper'
require 'time'

RSpec.describe Sections::LongFormats::LongFormatLine do # rubocop:disable Metrics/BlockLength
  describe 'format_line' do # rubocop:disable Metrics/BlockLength
    let!(:status_width) { Sections::LongFormatFilesSection::StatusWidth.new(0, 0, 0, 0) }
    let!(:file_status) { FileStatus.new('spec_helper.rb', 'spec') }

    context "when the target file's last modification time is before the current time and the difference is" do
      # 2021-12-15 12:00 の半年前は 2021-06-15 21:05:24

      context 'within half a year' do
        it 'includes the hour and the minute of the time' do
          allow(file_status).to receive(:time_stamp).and_return(Time.parse('2021-06-15 21:05:24'))
          format_line = Sections::LongFormats::LongFormatLine.new(file_status, status_width)
          allow(format_line).to receive(:current_time).and_return(Time.parse('2021-12-15 12:00'))
          expect(format_line.format_line).to include ' 6 15 21:05'
        end
      end

      context 'larger than half a year' do
        it 'includes the year of the time' do
          allow(file_status).to receive(:time_stamp).and_return(Time.parse('2021-06-15 21:05:23'))
          format_line = Sections::LongFormats::LongFormatLine.new(file_status, status_width)
          allow(format_line).to receive(:current_time).and_return(Time.parse('2021-12-15 12:00'))
          expect(format_line.format_line).to include ' 6 15  2021'
        end
      end
    end

    context "when the target file's last modification time is not before the current time and is" do
      context 'equal to the current time' do
        it 'includes the hour and the minute of the time' do
          allow(file_status).to receive(:time_stamp).and_return(Time.parse('2021-12-15 12:00'))
          format_line = Sections::LongFormats::LongFormatLine.new(file_status, status_width)
          allow(format_line).to receive(:current_time).and_return(Time.parse('2021-12-15 12:00'))
          expect(format_line.format_line).to include '12 15 12:00'
        end
      end

      context 'after the current time' do
        it 'includes the hour and the minute of the time' do
          allow(file_status).to receive(:time_stamp).and_return(Time.parse('2021-12-15 12:00:01'))
          format_line = Sections::LongFormats::LongFormatLine.new(file_status, status_width)
          allow(format_line).to receive(:current_time).and_return(Time.parse('2021-12-15 12:00:00'))
          expect(format_line.format_line).to include '12 15  2021'
        end
      end
    end
  end
end
