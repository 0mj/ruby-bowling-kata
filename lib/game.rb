class Game
  FRAMES = 10
  attr_accessor :frames, :rolls

  def initialize
    @frames = []
    @rolls = []
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
      frame_score = roll1 + roll2
      @frames << { frame: frame_number + 1, type: :open, rolls: [roll1,roll2], score: frame_score }
      roll_index += 2
    end
  end
end