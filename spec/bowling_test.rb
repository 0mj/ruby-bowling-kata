require_relative "../lib/game"
require "minitest/autorun"


class TestGame < Minitest::Test

  # "20 rolls of 0 must score 0"
  def test_gutter_game
    game = Game.new
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end



end