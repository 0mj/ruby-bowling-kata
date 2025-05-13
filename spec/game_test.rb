# https://gemini.google.com/share/a262940056d4
# https://gemini.google.com/share/3c3fcdcbac40
# https://gemini.google.com/share/7c27e507e861
require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_game_exists
    assert_instance_of Game, @game
  end

  # def ttest_gutter_game
  #   roll_many(20,0)
  # end

  # def ttest_frames_array_exists
  #   assert_instance_of Array, @game.frames
  #   assert_empty @game.frames
  # end

  # def test_for_ten_frames
  #   roll_many(20,0)
  #   @game.score
  #   assert_equal 10, @game.frames.size, "Should have 10 frames"
  # end

  # private
  # def roll_many(rolls, pins)
  #   rolls.times do
  #     @game.roll(pins)
  #   end
  # end

end