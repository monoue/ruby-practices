# frozen_string_literal: true

class TimeStamp
  attr_reader :text

  def initialize(file_mtime)
    @text = get_time_stamp(file_mtime)
  end

  private

  def get_time_stamp(file_mtime)
    month = format '%2d', file_mtime.month
    day = format '%2d', file_mtime.day
    time_or_year = get_time_or_year(file_mtime)
    "#{month} #{day} #{time_or_year}"
  end

  def recent?(file_mtime)
    return false if file_mtime > Time.now

    six_month = 60 * 60 * 24 * 365.2425 / 2
    file_mtime.to_f >= Time.now.to_f - six_month
  end

  def get_time_or_year(file_mtime)
    if recent?(file_mtime)
      format '%<hour>02d:%<min>02d', hour: file_mtime.hour, min: file_mtime.min
    else
      format '%5d', file_mtime.year
    end
  end
end
