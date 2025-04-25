class Game

  PINS = 10
  FRAMES = 10

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
      if @rolls.fetch(frame_index, 0 ) == PINS #strike!
        result += @rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0) + PINS
        frame_index += 1
      elsif spare?(frame_index)
       result +=  spare_bonus(frame_index)
       frame_index += 2
      else 
       result +=  @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index+1,0)
       frame_index += 2
      end
      
    end

    result
  end

  private
  def spare?(frame_index)
    @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index+1,0) == PINS #spare!
  end

  def spare_bonus(frame_index)
    @rolls.fetch(frame_index + 2, 0) + PINS
  end

end