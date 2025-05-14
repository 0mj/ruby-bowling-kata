class Game

  FRAMES = 10
  PINS = 10
<<<<<<< Updated upstream
  attr_accessor :frames, :rolls
=======

  attr_reader :frames
>>>>>>> Stashed changes

  def initialize
    @rolls = []
    @frames = []
  end

  def roll(pins)
    @rolls.push(pins)
  end

  def score
    result = 0
<<<<<<< Updated upstream
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

=======
    roll_i = 0
    frame  = 0

    FRAMES.times do
      
      if strike?(roll_i)
        result += strike_bonus(roll_i)
        roll_i += 1
      elsif spare?(roll_i)
        result += spare_bonus(roll_i)
        roll_i += 2 
      else
        result += open_frame(roll_i)
        @frames <<  box_score(roll_i) # @frames << {frame: frame + 1, box_score: box_score(roll_i) }
        roll_i += 2  
      end  
      
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
 
  def strike?(roll_index)
    @rolls.fetch(roll_index, 0) == PINS #STRIKE!
=======
  def box_score(roll_i)
    [@rolls.fetch(roll_i, 0), @rolls.fetch(roll_i + 1, 0)]  
>>>>>>> Stashed changes
  end
  def strike?(roll_i)
    @rolls.fetch(roll_i,0) == PINS 
  end
  def strike_bonus(roll_i)
    PINS + @rolls.fetch(roll_i + 1, 0) + @rolls.fetch(roll_i + 2, 0)
  end
  def spare?(roll_i)
    @rolls.fetch(roll_i, 0) + @rolls.fetch(roll_i + 1, 0) == PINS
  end
  def spare_bonus(roll_i)
    PINS + @rolls.fetch(roll_i + 2,0)
  end
  def open_frame(roll_i)
    @rolls.fetch(roll_i, 0) + @rolls.fetch(roll_i + 1, 0)
  end

end