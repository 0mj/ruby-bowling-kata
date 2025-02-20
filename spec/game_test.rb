# require_relative "../lib/game"
require "MiniTest/autorun"

class TestGame < MiniTest::Test
  
  def test_game_class_exists
    game = Game.new
    assert_instance_of Game, game
  end
  

end