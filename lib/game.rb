# frozen_string_literal: true

class Game
  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls.push(pins)
  end

  def score
    frame_index = 0
    result = 0
    10.times do
      result += if @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == 10
                  10 + @rolls.fetch(frame_index + 2, 0)
                else
                  @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0)
                end
      frame_index += 2
    end

    result
  end
end
