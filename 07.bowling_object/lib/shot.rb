class Shot
  def initialize(input)
    @mark = to_mark(input)
  end

  def mark
    @mark
  end

  private

  def to_mark(input)
    input == 'X' ? 10 : input.to_i
  end
end