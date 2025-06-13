require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  # ensure instantiation of Game is possible
  def test_game_class_exists
    assert_instance_of Game, @game
  end

  # 20 gutter balls must result in 0 score
  def test_gutter_game
    20.times do
      @game.roll(0)
    end
    assert_equal 0, @game.score
  end

  # bowler rolls 9,0,1,5,4,5 and 14 gutters must score 24
  def test_open_frame_rolls
    roll_two(9,0)
    roll_two(1,5)
    roll_two(4,5)
    roll_many_of_same(14,0)
    assert_equal 24, @game.score
  end

  # bowler rolls 7,3  4,4  and 16 gutters must score 22
  def test_spare
    roll_two(7,3)
    roll_two(4,4)
    roll_many_of_same(16,0)
    assert_equal 22, @game.score
  end

  # bowler rolls strike  4,4  and 16 gutters must score 26
  def test_strike
    strike
    roll_two(4,4)
    roll_many_of_same(16,0)
    assert_equal 26, @game.score
  end

  # bowler rolls 12 strikes for perfect game must score 300
  def test_perfect
    roll_many_of_same(12, Game::PINS)
    assert_equal 300, @game.score
  end

  # normal frame aka #roll_two instance method
  # Extract the simplest case first (normal frames)
  # Add this test to verify current behavior before refactoring
  def test_normal_frame_scoring
    roll_two(3, 4)
    roll_many_of_same(18, 0)
    assert_equal 7, @game.score
  end

  

  private
  def roll_two(r1,r2)
    @game.roll(r1)
    @game.roll(r2)
  end

  def roll_many_of_same(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end
  def strike
    @game.roll(Game::PINS)
  end
end