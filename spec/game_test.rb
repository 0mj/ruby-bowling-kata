require 'minitest/autorun'
require_relative '../lib/game'

class TestGame < MiniTest::Test

  def test_game_class_exists
    game = Game.new
    assert_instance_of Game, game
  end

  # 20 rolls of 0 must score 0
  def test_gutter_game
    game = Game.new
    20.times do
      game.roll(0)
    end
    assert_equal 0, game.score
  end

end