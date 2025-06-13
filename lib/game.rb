class Game

  PINS = 10
  FRAMES = 10

  def initialize
    @rolls = []
  end

  def roll(pins)
    raise ArgumentError, "invalid number of pins" if pins < 0 || pins > PINS
    @rolls << pins
  end

  def score
    result = 0
    roll_i = 0
    FRAMES.times do
      if strike?(roll_i)
        result += strike_bonus(roll_i)
        roll_i += 1
      elsif spare?(roll_i)
        result += spare_bonus(roll_i)
        roll_i += 2
      else
        frame_score, rolls_used = calculate_normal_frame_score(roll_i)
        result += frame_score
        roll_i += rolls_used
      end
    end
    result
  end

  def calculate_normal_frame_score(roll_i)
    [normal_frame(roll_i), 2]
  end

  private
  def spare?(roll_i)
    @rolls.fetch(roll_i,0) + @rolls.fetch(roll_i + 1, 0) == PINS #spare
  end
  def spare_bonus(roll_i)
    PINS + @rolls.fetch(roll_i + 2, 0)
  end
  def strike?(roll_i)
    @rolls.fetch(roll_i, 0) == PINS #strike
  end
  def strike_bonus(roll_i)
    PINS + @rolls.fetch(roll_i + 1, 0) + @rolls.fetch(roll_i + 2, 0)
  end
  def normal_frame(roll_i)
    @rolls.fetch(roll_i,0) + @rolls.fetch(roll_i + 1, 0)
  end
end