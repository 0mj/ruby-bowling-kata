require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end

  def test_gutter_game
    roll_many(20,0)
    assert_equal 0, @game.score
  end

  def test_ten_ones_ten_gutter
    roll_many(10,0)
    roll_many(10,1)
    assert_equal 10, @game.score
  end

  # roll [9,1][6,3][7,1] & 14 gutters
  def test_spare
    roll_frame(9,1) #spare
    roll_frame(6,3)
    roll_frame(7,1)
    roll_many(14,0)
    assert_equal 33, @game.score  
  end

  def test_strike
    @game.roll(Game::PINS)
    roll_frame(9,0)
    roll_frame(9,0)
    roll_many(14,0)
    assert_equal 37, @game.score
  end

  def test_perfect_game
    roll_many(12,Game::PINS)
    assert_equal 300, @game.score
  end

  private
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

  def roll_frame(r1, r2)
    @game.roll(r1)
    @game.roll(r2)
  end

end