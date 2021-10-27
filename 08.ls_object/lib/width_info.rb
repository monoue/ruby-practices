class Width
  attr_reader :nlink, :owner_name, :group_name, :size

  def initialize(long_format_line_infos)
    @nlink = long_format_line_infos.map { |info| count_digits(info.nlink) }.max
    @owner_name = long_format_line_infos.map { |info| info.owner_name.length }.max
    @group_name = long_format_line_infos.map { |info| info.group_name.length }.max
    @size = long_format_line_infos.map { |info| count_digits(info.size) }.max
  end

  private

  def count_digits(num)
    Math.log10(num.abs).to_i + 1
  rescue FloatDomainError
    1
  end
end
