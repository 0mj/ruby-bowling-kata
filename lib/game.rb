class Game
  FRAMES = 10
  PINS = 10
  ROLLS_PER_NORMAL_FRAME = 2
  STRIKE_ROLLS_USED = 1
  NEXT_ROLL_OFFSET = 1
  SECOND_NEXT_ROLL_OFFSET = 2

  attr_accessor :rolls

  def initialize
    @rolls = []
  end

  def roll(pins)
    raise ArgumentError, "Invalid number of pins" if pins < 0 || pins > PINS
    @rolls << pins
  end

  def score
    result = 0
    current_roll = 0
    FRAMES.times do
      frame_score, rolls_used = calculate_frame_score(current_roll)
      result += frame_score
      current_roll += rolls_used
    end
    result
  end

  private

  def calculate_frame_score(current_roll)
    if strike?(current_roll)
      [strike_bonus(current_roll), STRIKE_ROLLS_USED]
    elsif spare?(current_roll)
      [spare_bonus(current_roll), ROLLS_PER_NORMAL_FRAME]
    else
      [normal_frame_score(current_roll), ROLLS_PER_NORMAL_FRAME]
    end
  end

  def spare?(current_roll)
    @rolls.fetch(current_roll, 0) + @rolls.fetch(current_roll + NEXT_ROLL_OFFSET, 0) == PINS
  end

  def spare_bonus(current_roll)
    PINS + @rolls.fetch(current_roll + SECOND_NEXT_ROLL_OFFSET, 0) 
  end

  def strike?(current_roll)
    @rolls.fetch(current_roll, 0) == PINS
  end

  def strike_bonus(current_roll)
    PINS + @rolls.fetch(current_roll + NEXT_ROLL_OFFSET, 0) + @rolls.fetch(current_roll + SECOND_NEXT_ROLL_OFFSET, 0)
  end

  def normal_frame_score(current_roll)
    @rolls.fetch(current_roll, 0) + @rolls.fetch(current_roll + NEXT_ROLL_OFFSET, 0)
  end
end