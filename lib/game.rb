# frozen_string_literal: true

# game
class Game
  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls.push(pins)
  end

  def score
    @rolls.sum
  end
end
