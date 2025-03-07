class Frame

  attr_reader :rolls

  def initialize
    @rolls = []
  end

  def add_roll(pins)
    @rolls << pins
  end

  def strike?
    @rolls.size == 1 && @rolls[0] == 10
  end

  def spare?
    @rolls.size == 2 && (@rolls[0] + @rolls[1] == 10)
  end

  def complete?
    strike? || @rolls.size == 2
  end

  def open?
    complete? && !strike? && !spare?
  end

end