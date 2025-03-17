class Game

  FRAMES = 10
  PINS = 10

  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    result = 0
    frame_index = 0

    FRAMES.times do
<<<<<<< Updated upstream
     
     if strike?(frame_index)
        result += strike_bonus(frame_index)
        frame_index += 1
      elsif spare?(frame_index)
        result += spare_bonus(frame_index)
=======
      if @rolls.fetch(frame_index,0) == PINS
        result += PINS + @rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0)
        frame_index +=1
      elsif spare?(frame_index)
        result += PINS + spare_bonus(frame_index)
>>>>>>> Stashed changes
        frame_index += 2
      else
        result += @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0)
        frame_index += 2
      end
<<<<<<< Updated upstream
      # puts "Frame:#{frame_index} Score:#{result}"
=======
      
>>>>>>> Stashed changes
    end
    result
  end

  private

  def spare?(frame_index)
    @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == PINS #spare!
  end

  def spare_bonus(frame_index)
    PINS + @rolls.fetch(frame_index + 2, 0) 
  end

  def strike?(frame_index)
    @rolls.fetch(frame_index, 0) == PINS #strike!
  end

  def strike_bonus(frame_index)
    PINS + @rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0)
  end

end