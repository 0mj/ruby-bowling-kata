class Game
  FRAMES = 10
  PINS = 10
  attr_accessor :frames, :rolls

  def initialize
    @rolls = []
    @frames = []
  end
  def roll(pins)
    @rolls << pins
  end
  def score
    result = 0
    roll_index = 0
    frame = 0 

    FRAMES.times do
      frame += 1
      
      if strike?(roll_index)
        result += strike_bonus(roll_index)
        @frames << { frame: frame,  box_score: [box_strike],  score: result } 
        roll_index += 1
      
      elsif spare?(roll_index)
        result += spare_bonus(roll_index)
        @frames << { frame: frame, box_score: box_spare(roll_index), score: result }
        roll_index += 2
        
      else
        result += @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) 
        @frames << { frame: frame, box_score: box_open(roll_index), score: result }
        roll_index += 2
        
      end

    end
    result
  end
  def box_strike
    "X"
  end
  def box_spare(roll_index)
    [@rolls.fetch(roll_index, 0),"/"]    
  end

  def box_open(roll_index)
    [@rolls.fetch(roll_index, 0), @rolls.fetch(roll_index + 1,0)]
  end
  
  private
 
  def strike?(roll_index)
    @rolls.fetch(roll_index, 0) == PINS #STRIKE!
  end
  def strike_bonus(roll_index)
    PINS + @rolls.fetch(roll_index + 1, 0) + @rolls.fetch(roll_index + 2, 0)
  end
  def spare?(roll_index)
    @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) == PINS #spare!
  end
  def spare_bonus(roll_index)
    PINS + @rolls.fetch(roll_index + 2, 0)
  end
end
