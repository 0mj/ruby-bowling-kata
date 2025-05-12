# https://gemini.google.com/share/a262940056d4
# https://gemini.google.com/share/3c3fcdcbac40
# https://gemini.google.com/share/7c27e507e861
require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def ttest_game_exists
    assert_instance_of Game, @game
  end

  def ttest_gutter_game
    roll_many(20,0)
  end

  def ttest_frames_array_exists
    assert_instance_of Array, @game.frames
    assert_empty @game.frames
  end


  def test_frames_array_structure
    roll_many(20,0)
    assert_equal 10, @game.frames.size, "Should have 10 frames"
    puts @game.score
    # @game.frames.each do |frame|
    #   assert_equal [:frame, :type, :rolls, :score].sort, frame.keys.sort, "Frame should have keys: :frame, :type, :rolls, :score"
    #   assert_instance_of Integer, frame[:frame], "Frame number should be an Integer"
    #   assert_instance_of Symbol, frame[:type], "Frame type should be a Symbol"
    #   assert_instance_of Array, frame[:rolls], "Rolls should be an Array"
    #   assert_instance_of Integer, frame[:score], "Score should be an Integer"
    # end
  end

  private
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

end