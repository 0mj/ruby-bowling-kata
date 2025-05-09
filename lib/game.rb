class Game
  FRAMES = 10
  PINS = 10

  
  attr_accessor :rolls, :frames

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

  private

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
        @frames << { frame: frame_number + 1, type: :strike, rolls: frame_rolls, score: frame_score }
      elsif spare?(roll_index)
        frame_score = PINS + @rolls.fetch(roll_index + 2, 0)
        frame_rolls << roll2
        frame_rolls << @rolls.fetch(roll_index + 2, 0)
        roll_index += 2
        @frames << { frame: frame_number + 1, type: :spare, rolls: frame_rolls, score: frame_score }
      else
        frame_score = roll1 + roll2
        frame_rolls << roll2
        roll_index += 2
        @frames << { frame: frame_number + 1, type: :open, rolls: frame_rolls, score: frame_score }
      end
    end
     
    calculate_tenth_frame_score
  end

  def calculate_tenth_frame_score
     last_frame = @frames.last
     roll_index = @rolls.size - last_frame[:rolls].size
     roll1 = @rolls.fetch(roll_index, 0)
     roll2 = @rolls.fetch(roll_index + 1, 0)
     roll3 = @rolls.fetch(roll_index + 2, 0)
    if @frames.size == 10
        if strike?(roll_index)
            last_frame[:score] = 10 + (@rolls.fetch(roll_index + 1, 0) || 0) + (@rolls.fetch(roll_index + 2, 0) || 0)
        elsif spare?(roll_index)
             last_frame[:score] = 10 + (@rolls.fetch(roll_index + 2, 0) || 0)
        else
            last_frame[:score] = roll1 + roll2
        end
    end
  end
  def spare?(frame_index)
    @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == PINS
  end

  def spare_bonus(frame_index)
    PINS + @rolls.fetch(frame_index + 2, 0)
  end

  def strike?(frame_index)
    @rolls.fetch(frame_index, 0) == PINS
  end

  def strike_bonus(frame_index)
     PINS + @rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0)
  end
end
