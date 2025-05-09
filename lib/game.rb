# https://gemini.google.com/share/a262940056d4

class Game
  attr_accessor :rolls, :frames
  FRAMES = 10
  PINS = 10

  def initialize
    @rolls = []
    @frames = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    calculate_score
    @frames.sum { |frame| frame[:score] }
  end

  

  def calculate_score
    @frames.clear
    roll_index = 0

    FRAMES.times do |frame_number|
      roll1 = @rolls.fetch(roll_index, 0)
      roll2 = @rolls.fetch(roll_index + 1, 0)
      frame_score = 0
      frame_rolls = [roll1]

      if strike?(roll_index)
        frame_score = PINS + @rolls.fetch(roll_index + 1, 0) + @rolls.fetch(roll_index + 2, 0)
        frame_rolls << @rolls.fetch(roll_index + 1, 0)
        frame_rolls << @rolls.fetch(roll_index + 2, 0)
        roll_index += 1
      elsif spare?(roll_index)
        frame_score = PINS + @rolls.fetch(roll_index + 2, 0)
        frame_rolls << roll2
        frame_rolls << @rolls.fetch(roll_index + 2, 0)
        roll_index += 2
      else
        frame_score = roll1 + roll2
        frame_rolls << roll2
        roll_index += 2
      end
      @frames << { frame: frame_number + 1, type: frame_type(roll1, roll2), rolls: frame_rolls, score: frame_score }
    end
  end

  def frame_type(roll1, roll2)
    return :strike if roll1 == PINS
    return :spare if roll1 + roll2 == PINS
    :open
  end

  def strike?(frame_index)
    @rolls.fetch(frame_index, 0) == PINS
  end
  def spare?(frame_index)
    @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == PINS
  end
end