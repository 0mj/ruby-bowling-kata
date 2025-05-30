class Game
  FRAMES = 10
  PINS = 10
  attr_accessor :card
  def initialize
    @rolls = []
    @card = []
  end
  def roll(pins)
    @rolls << pins
  end

  def tenth_frame_strike?
    # @card.include?({frame: 10, type: "STRIKE", frame_score: Game::PINS })
    @card.any? { |f| f[:frame] == 10 && f[:type] == "STRIKE" }
  end

  def score
    result = 0
    rollndx = 0
    crd_frm = 0

    FRAMES.times do
      if strike?(rollndx)
        frame_score = strike_bonus(rollndx)
        result += frame_score
        @card << { frame: crd_frm += 1, type: "STRIKE", frame_score: frame_score, total: result }
        rollndx += 1

      elsif spare?(rollndx)
        frame_score = spare_bonus(rollndx)
        result += frame_score
        @card << { frame: crd_frm += 1, type: "SPARE", frame_score: frame_score, total: result }
        rollndx += 2
      else 
        frame_score = @rolls.fetch(rollndx, 0) + @rolls.fetch(rollndx + 1, 0)
        result += frame_score
        @card << { frame: crd_frm += 1, type: "OPEN", frame_score: frame_score, total: result }
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