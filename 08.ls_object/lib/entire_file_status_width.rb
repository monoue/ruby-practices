# frozen_string_literal: true

class EntireFileStatusWidth
  def initialize(file_statuses)
    @file_statuses = file_statuses
  end

  def nlink
    file_statuses.map { |info| count_digits(info.nlink) }.max
  end

  def owner_name
    file_statuses.map { |info| info.owner_name.length }.max
  end

  def group_name
    file_statuses.map { |info| info.group_name.length }.max
  end

  def size
    file_statuses.map { |info| count_digits(info.size) }.max
  end

  private

  attr_reader :file_statuses

  def count_digits(num)
    Math.log10(num.abs).to_i + 1
  rescue FloatDomainError
    1
  end
end
