require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end
  def test_game_class
    
    assert_instance_of Game, @game
  end

  def test_gutters
    roll_many(20,0)
    assert_equal 0, @game.score
  end

  def test_ones
    roll_many(20,1)
    assert_equal 20, @game.score
  end

  def test_spare
    roll_frame(8,2)
    roll_frame(8,0)
    roll_many(16,0)
    assert_equal 26, @game.score
  end

  def test_strike
    strike
<<<<<<< Updated upstream
    roll_frame(7,2)
=======
    roll_frame(9,0)
>>>>>>> Stashed changes
    roll_many(16,0)
    assert_equal 28, @game.score
  end

  def test_perfect
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
  end

<<<<<<< Updated upstream
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
=======
  def test_box_score
    roll_frame(4,3)
    roll_many(18,0)
    @game.score
    assert_equal  [[4, 3], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]], @game.frames
>>>>>>> Stashed changes
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
  def strike
    @game.roll(Game::PINS)
  end

end