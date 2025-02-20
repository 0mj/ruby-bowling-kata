require 'minitest/autorun'
require_relative '../lib/game'

class TestGame < MiniTest::Test

  def test_game_class_exists
    game = Game.new
    assert_instance_of Game, game
  end

  # 20 rolls of zero must score zero
  def test_gutter_game
    game = Game.new
    20.times do
      game.roll(0)
    end
    assert_equal 0, game.score
  end

  # 10 rolls of 1 & 10 rolls of zero
  def test_ten_ones_ten_gutters
    10.times do
      @game.roll(1)
    end
    10.times do 
      @game.roll(0)
    end
    assert_equal 10, @game.score
  end

end