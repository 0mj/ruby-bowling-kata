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
    raise ArgumentError, "Invalid number of pins" if pins < 0 || pins > 10
    @rolls << pins
  end


  def score
    result = 0
    roll_index = 0
    FRAMES.times do
      frame_score, rolls_used = calculate_frame_score(roll_index)
      result += frame_score
      roll_index += rolls_used
    end
    result
  end


 


  def calculate_frame_score(roll_index)
    if strike?(roll_index)
      [strike_bonus(roll_index), 1]
    elsif spare?(roll_index)
      [spare_bonus(roll_index), 2]
    else
      [normal_frame_score(roll_index), 2]
    end
  end

 
  def spare?(roll_index)
    @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1, 0) == PINS #spare
  end
  def spare_bonus(roll_index)
    PINS + @rolls.fetch(roll_index + 2, 0) 
  end
  def strike?(roll_index)
    @rolls.fetch(roll_index, 0) == PINS # strike
  end
  def strike_bonus(roll_index)
    PINS + @rolls.fetch(roll_index + 1, 0) +@rolls.fetch(roll_index + 2, 0)
  end
  def normal_frame_score(roll_index)
    @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1, 0)

  end
end