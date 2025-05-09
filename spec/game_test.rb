# https://gemini.google.com/share/a262940056d4
require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_gutter_game
    roll_many(20, 0)
    @game.calculate_score # Explicitly call calculate_score
    assert_equal 0, @game.frames.sum{|frame| frame[:score]}, "Gutter game should score 0"
  end

  def test_all_ones
    roll_many(20, 1)
    @game.calculate_score
    assert_equal 20, @game.frames.sum{|frame| frame[:score]}, "All ones game should score 20"
    puts @game.frames
  end

  def test_spare
    roll_frame(5, 5) # Spare in the first frame
    roll_many(18, 1)
    @game.calculate_score
    assert_equal 29, @game.frames.sum{|frame| frame[:score]}, "Spare should add the next roll as a bonus"
    puts @game.frames
  end

  def test_strike
    @game.roll(10) # Strike in the first frame
    roll_many(18, 1)
    @game.calculate_score
    assert_equal 30, @game.frames.sum{|frame| frame[:score]}, "Strike should add the next two rolls as a bonus"
    puts @game.frames
  end

  private
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end
  def roll_frame(roll1, roll2)
    @game.roll(roll1)
    @game.roll(roll2)
  end

end