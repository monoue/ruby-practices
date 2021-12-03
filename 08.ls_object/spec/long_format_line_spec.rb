# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Sections::LongFormats::LongFormatLine do # rubocop:disable Metrics/BlockLength
  describe 'format_line' do # rubocop:disable Metrics/BlockLength
    let!(:file_status_mock) { double('file_status_mock') }
    let!(:entire_file_status_width_mock) { double('entire_file_status_width_mock') }
    before do
      filename = 'spec_helper.rb'
      file_path = "spec/#{filename}"
      lstat = File.lstat(file_path)
      allow(file_status_mock).to receive(:filename).and_return(filename)
      allow(file_status_mock).to receive(:mode).and_return(Sections::LongFormats::FileMode.new(lstat, file_path))
      allow(file_status_mock).to receive(:nlink).and_return(lstat.nlink)
      allow(file_status_mock).to receive(:owner_name).and_return(Etc.getpwuid(lstat.uid).name)
      allow(file_status_mock).to receive(:group_name).and_return(Etc.getgrgid(lstat.gid).name)
      allow(file_status_mock).to receive(:file_size).and_return(lstat.size)
      allow(file_status_mock).to receive(:blocks).and_return(lstat.blocks)
      allow(file_status_mock).to receive(:multibyte_chars_of_filename_num)
        .and_return(filename.chars.count { |char| !char.ascii_only? })
      allow(file_status_mock).to receive(:multibyte_filename_length)
        .and_return(filename.length + file_status_mock.multibyte_chars_of_filename_num * 2)
      allow(entire_file_status_width_mock).to receive(:nlink).and_return(0)
      allow(entire_file_status_width_mock).to receive(:owner_name).and_return(0)
      allow(entire_file_status_width_mock).to receive(:group_name).and_return(0)
      allow(entire_file_status_width_mock).to receive(:file_size).and_return(0)
    end
    days_per_year = 365.2425
    half_a_year_ago = Time.now - 60 * 60 * 24 * days_per_year / 2

    context "when the target file's last modification time is" do # rubocop:disable Metrics/BlockLength
      context 'within half a year ago' do
        last_modification_time = half_a_year_ago + 1

        it 'includes the hour and the minute of the time' do
          allow(file_status_mock).to receive(:time_stamp).and_return(last_modification_time)
          expect(
            Sections::LongFormats::LongFormatLine.new(file_status_mock, entire_file_status_width_mock).format_line
          ).to include(last_modification_time.strftime('%R'))
        end

        it 'does not include the year of the time' do
          allow(file_status_mock).to receive(:time_stamp).and_return(last_modification_time)
          expect(
            Sections::LongFormats::LongFormatLine.new(file_status_mock, entire_file_status_width_mock).format_line
          ).to_not include(last_modification_time.strftime('%_5Y'))
        end
      end

      context 'equal to half a year ago' do
        last_modification_time = half_a_year_ago

        it 'includes the year of the time' do
          allow(file_status_mock).to receive(:time_stamp).and_return(last_modification_time)
          expect(
            Sections::LongFormats::LongFormatLine.new(file_status_mock, entire_file_status_width_mock).format_line
          ).to include(last_modification_time.strftime('%_5Y'))
        end

        it 'does not include the hour and the minute of the time' do
          allow(file_status_mock).to receive(:time_stamp).and_return(last_modification_time)
          expect(
            Sections::LongFormats::LongFormatLine.new(file_status_mock, entire_file_status_width_mock).format_line
          ).to_not include(last_modification_time.strftime('%R'))
        end
      end

      context 'older than half a year ago' do
        last_modification_time = half_a_year_ago - 1

        it 'includes the year of the time' do
          allow(file_status_mock).to receive(:time_stamp).and_return(last_modification_time)
          expect(
            Sections::LongFormats::LongFormatLine.new(file_status_mock, entire_file_status_width_mock).format_line
          ).to include(last_modification_time.strftime('%_5Y'))
        end

        it 'does not include the hour and the minute of the time' do
          allow(file_status_mock).to receive(:time_stamp).and_return(last_modification_time)
          expect(
            Sections::LongFormats::LongFormatLine.new(file_status_mock, entire_file_status_width_mock).format_line
          ).to_not include(last_modification_time.strftime('%R'))
        end
      end
    end
  end
end
