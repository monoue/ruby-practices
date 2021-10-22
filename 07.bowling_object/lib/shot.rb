class Shot
  def initialize(mark)
    @score = to_score(mark)
  end

  def score
    @score
  end

  private

  def to_score(mark)
    mark == 'X' ? 10 : mark.to_i
  end
end
