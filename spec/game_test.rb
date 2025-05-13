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

  def test_gutter_game
    roll_many(20,0)
    assert_equal 0, @game.score
  end

  def test_frames_array_exists
    assert_instance_of Array, @game.frames
    assert_empty @game.frames
  end


  def test_frames_array_structure
    roll_many(20,0)
    @game.score
    assert_equal 10, @game.frames.size, "Should have 10 frames"
    @game.frames.each do |frame|
      assert_equal [:frame, :type, :rolls, :score].sort, frame.keys.sort, "Frame should have keys: :frame, :type, :rolls, :score"
      assert_instance_of Integer, frame[:frame], "Frame number should be an Integer"
      assert_instance_of Symbol, frame[:type], "Frame type should be a Symbol"
      assert_instance_of Array, frame[:rolls], "Rolls should be an Array"
      assert_instance_of Integer, frame[:score], "Score should be an Integer"
    end
  end

  def test_all_ones
    roll_many(20, 1)
    @game.score
    assert_equal 20, @game.frames.sum{|frame| frame[:score]}, "All ones game should score 20"
  end

  def test_spare
    roll_frame(5, 5) # Spare in the first frame
    roll_many(18, 1)
    @game.score
    assert_equal 29, @game.frames.sum{|frame| frame[:score]}, "Spare should add the next roll as a bonus"
  end

  def test_strike
    @game.roll(Game::PINS) # Strike in the first frame
    roll_many(18, 1)
    @game.score
    assert_equal 30, @game.frames.sum{|frame| frame[:score]}, "Strike should add the next two rolls as a bonus"
  end

  private
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

  def roll_frame(roll1,roll2)
    @game.roll(roll1)
    @game.roll(roll2)
  end

end