# frozen_string_literal: true

class Game
  PINS = 10
  FRAMES = 10

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
      if strike?(frame_index)
        puts "STRIKE!"
        result += PINS + strike_bonus(frame_index)
        puts "# of rolls completed = #{frame_index} score = #{result}"
        frame_index += 1
      elsif spare?(frame_index)
        result += PINS + spare_bonus(frame_index)
        puts "# of rolls completed = #{frame_index} score = #{result}"
        frame_index += 2
      else
        result += @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0)
        puts "# of rolls completed = #{frame_index + 1} score = #{result}"
        frame_index += 2
      end

      
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

  def strike_bonus(frame_index)
    puts "STRIKE BONUS"
    puts "frame index = #{frame_index}"
    @rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0)
  end

  def strike?(frame_index)
    @rolls.fetch(frame_index) == PINS
  end
end
