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

  # test score bowler that rolls 4,3  5,3  6,1  and 14 gutters.  Should result in score of 22.
  def test_open_frame_bowler
    roll_frame(4,3)
    roll_frame(5,3)
    roll_frame(6,1)
    roll_many(14,0)
    assert_equal 22, @game.score
  end

  def test_spare
    roll_frame(9,1) #spare
    roll_frame(7,2)
    roll_many(16,0)
    assert_equal 26, @game.score
  end

  def test_strike
    @game.roll(Game::PINS)
    roll_frame(7,2)
    roll_many(16,0)
    assert_equal 28, @game.score
  end

  def test_perfect_game
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
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
