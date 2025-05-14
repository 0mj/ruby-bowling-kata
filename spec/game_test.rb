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
    strike
    roll_frame(7,2)
    roll_many(16,0)
    assert_equal 28, @game.score
  end

  def test_perfect_game
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
  end

  def test_frames_array
    strike
    roll_frame(5,4)
    roll_many(16,0)
    @game.score
    @game.frames.each do |frame|
      assert_equal [:frame, :box_score, :score].sort, frame.keys.sort, "Frame should have keys: :frame, :box_score, :score"
      assert_instance_of Integer, frame[:frame], "Frame number should be an Integer"
      assert_instance_of Array, frame[:box_score], "Rolls should be an Array"
      assert_instance_of Integer, frame[:score], "Score should be an Integer"
    end
  end

  # Box score represents the 2 boxes at top of frame box.  Frame box holds running score and box score holds indiviidual roll.
  def test_box_score
    strike
    roll_frame(9,0)
    roll_frame(7,3)
    roll_frame(5,3)
    roll_many(12,0)
    @game.score
    puts @game.frames
  end

  private
  def strike
    @game.roll(Game::PINS)
  end
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
