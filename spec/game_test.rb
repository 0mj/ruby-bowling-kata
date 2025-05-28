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
    roll_many_of_same(20, 0)
    assert_equal 0, @game.score
  end

  def test_tenOne_tenZero
    roll_many_of_same(10, 0)
    roll_many_of_same(10, 1)
    assert_equal 10, @game.score
  end

  def test_spare
    roll_two(9, 1)
    @game.roll(7)
    roll_many_of_same(17,0)
    assert_equal 24, @game.score
  end

  def test_strike
    strike
    roll_two(9,0)
    roll_many_of_same(16,0)
    assert_equal 28, @game.score
  end

  def test_perfect_game
    roll_many_of_same(12, Game::PINS)
    assert_equal 300, @game.score
  end

  private
  def roll_many_of_same(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end
  def roll_two(r1, r2)
    @game.roll(r1)
    @game.roll(r2)
  end
  def strike
    @game.roll(Game::PINS)
  end
end