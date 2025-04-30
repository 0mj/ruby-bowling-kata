require 'minitest/autorun'
require_relative '../lib/game'

class TestGame < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_game_exist
    assert_instance_of Game, @game
  end

  # sally no bowl. sally throw gutters x20
  # sally score 0
  def test_gutter_sally
    roll_many(20,0)
    assert_equal 0, @game.score
  end

  # sally improved. throws [9,0][9,0][9,0]
  # and x14 gutters
  def test_nine_zero
    roll_frame(9,0)
    roll_frame(9,0)
    roll_frame(9,0)
    roll_many(14,0)
    assert_equal 27, @game.score
  end

  # sally got a spare! [9,1][9,0][3,6]
  # and x14 gutters
  def test_spare
    roll_frame(9,1)
    roll_frame(9,0)
    roll_frame(3,6)
    roll_many(14,0)
    assert_equal 37, @game.score
  end

  def test_strike
    @game.roll(10)
    roll_frame(5,4)
    roll_many(16,0)
    assert_equal 28, @game.score
  end

  private
  def roll_frame(roll1, roll2)
    @game.roll(roll1)
    @game.roll(roll2)
  end

  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

end