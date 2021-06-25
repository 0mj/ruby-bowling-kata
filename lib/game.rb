# frozen_string_literal: true

class Game
  FRAMES = 10
  PINS = 10
  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls.push(pins)
  end

  def score
    result = 0
    frame_index = 0

    FRAMES.times do
      result += if spare?(frame_index)
                  PINS + spare_bonus(frame_index)  # 10 pins + the spare bonus
                else
                  @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0)
                end
      frame_index += 2
    end

    result
  end

  private

  def spare?(frame_index)
    @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == PINS
  end

  def spare_bonus(frame_index)
    @rolls.fetch(frame_index + 2, 0)
  end
end
