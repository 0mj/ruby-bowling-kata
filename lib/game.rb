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
    rollndx = 0

    FRAMES.times do
      if strike?(rollndx)
        result += strike_bonus(rollndx)
        rollndx += 1
      elsif spare?(rollndx)
        result += spare_bonus(rollndx)
        rollndx += 2
      else 
        result += @rolls.fetch(rollndx, 0) + @rolls.fetch(rollndx + 1, 0)
        rollndx += 2
      end
      
    end
    result
  end
  private
  def spare?(rollndx)
    @rolls.fetch(rollndx, 0) + @rolls.fetch(rollndx + 1, 0) == PINS #spare
  end
  def spare_bonus(rollndx)
    PINS + @rolls.fetch(rollndx + 2, 0)
  end
  def strike?(rollndx)
    @rolls.fetch(rollndx, 0) == PINS #strike
  end
  def strike_bonus(rollndx)
   PINS + @rolls.fetch(rollndx + 1, 0) + @rolls.fetch(rollndx + 2, 0) 
  end
end