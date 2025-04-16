require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < MiniTest::Test

  def setup
    @game = Game.new
  end

  def ttest_game_class_exists
    assert_instance_of Game, @game
  end

  # 20 rolls of  0 must score 0
  def ttest_gutter_game
    roll_many(20,0)
    assert_equal 0, @game.score
  end

  # 10 rolls of 0 and 10 rolls of 1 must score 10
  def ttest_ten_one_ten_zero
    roll_many(10,0)
    roll_many(10,1)
    assert_equal 10, @game.score
  end

  # roll [9,1] spare roll[5,4] and 16 gutters must score 24
  def ttest_spare
    roll_frame(9,1)
    roll_frame(5,4)
    roll_many(16,0)
    assert_equal 24, @game.score
  end

  # roll strike, 3,4 must score 24
  def ttest_roll_strike
    @game.roll(10)
    roll_frame(3,4)
    roll_many(16,0)
    assert_equal 24, @game.score
  end

  # perfect game 12 strikes.  Must score 300.
  def ttest_perfect_game
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
  end
  # [x][x][7,3][4,6][x][0,7][9,0][8,0][7,2][xxx] must score 161. bowlinggenius.com
  def test_game_scenario_1
    strike
    strike
    roll_frame(7,3)
    roll_frame(4,6)
    strike
    roll_frame(0,7)
    roll_frame(9,0)
    roll_frame(8,0)
    roll_frame(7,2)
    strike
    strike
    strike
    assert_equal 161, @game.score
  end

  private
  def roll_many(rolls,pins)
    rolls.times do
      @game.roll(pins)
    end
  end

  def roll_frame(r1,r2)
    @game.roll(r1)
    @game.roll(r2)
  end

  def strike
    @game.roll(Game::PINS)
  end

end