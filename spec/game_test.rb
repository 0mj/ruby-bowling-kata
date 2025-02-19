require_relative "../lib/game"
require "minitest/autorun"


class TestGame < Minitest::Test

  def setup
    @game = Game.new
  end

  # 20 rolls of 0 must score 0
  def test_gutter_game
    
    20.times do
      @game.roll(0)
    end
    assert_equal 0, @game.score
  end

  # 10 rolls of 1 & 10 rolls of zero
  def test_ten_ones_ten_gutters
    roll_many(10, 1)
    roll_many(10, 0)
    assert_equal 10, @game.score
  end

  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

  def test_spare
    roll_spare
    @game.roll(3)
    assert_equal 16, @game.score
  end

  def roll_spare
    roll_many(2,5)
  end

  def test_strike
    roll_strike
    @game.roll(3)
    @game.roll(4)
    roll_many(16,0)
    assert_equal 24, @game.score
  end

  def test_perfect_game
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
  end

  def roll_strike
    @game.roll(Game::PINS)
  end


end