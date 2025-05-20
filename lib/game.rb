class Game
  PINS = 10
  FRAMES = 10
  attr_reader :scorecard
  def initialize
    @rolls = []
    @scorecard = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    result = 0 
    roll_ndx = 0
    frame = 0
    FRAMES.times do
      if strike?(roll_ndx)
        result += strike_bonus(roll_ndx)
        write_scorecard(frame, result, "strike", [PINS, "X"])
        roll_ndx += 1
        frame += 1
      elsif spare?(roll_ndx)
        result += spare_bonus(roll_ndx)
        write_scorecard(frame, result, "spare", [@rolls.fetch(roll_ndx,0), @rolls.fetch(roll_ndx + 1,0), "/"])
        roll_ndx += 2
        frame += 1
      else
        result += open_frame(roll_ndx)
        write_scorecard(frame, result, "open", [@rolls.fetch(roll_ndx,0), @rolls.fetch(roll_ndx + 1,0)])
        roll_ndx += 2
        frame += 1
      end
        
    end
    result
  end


  private
  def spare_bonus(roll_ndx)
    PINS + @rolls.fetch(roll_ndx + 2, 0)
  end
  def spare?(roll_ndx)
    @rolls.fetch(roll_ndx, 0) + @rolls.fetch(roll_ndx + 1, 0) == PINS
  end
  def strike?(roll_ndx)
    @rolls.fetch(roll_ndx, 0) == PINS
  end
  def strike_bonus(roll_ndx)
    PINS + @rolls.fetch(roll_ndx + 2, 0) + @rolls.fetch(roll_ndx + 1, 0)
  end
  def open_frame(roll_ndx)
    @rolls.fetch(roll_ndx, 0) + @rolls.fetch(roll_ndx + 1, 0)
  end
  def write_scorecard(frame, result, type, rolls)
   
      @scorecard << {frame: frame + 1, framescore: result, type: type, rolls: rolls }
   
  end
  
end