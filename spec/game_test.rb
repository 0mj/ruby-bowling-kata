require_relative '../lib/game'
require 'minitest/autorun'

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

  def test_10_gutter_10_one
    roll_many(10,0)
    roll_many(10,1)
    assert_equal 10, @game.score
  end

  def test_spare
    complete_frame(9,1)
    complete_frame(9,0)
    complete_frame(5,3)
    roll_many(14,0)
    assert_equal 36, @game.score
  end

  def test_strike_spare
    @game.roll(Game::PINS) # 10 + 4 + 6 = 20
    complete_frame(4,6) # 4 + 6 + 9 + 20 = 39
    complete_frame(9,0) # 9 + 0 + 39 = 48
    roll_many(14,0)
    assert_equal 48, @game.score
    assert_includes @game.scorecard,  { frame: 1, framescore: 20, type: "strike", rolls: [10,"X"]}
    assert_includes @game.scorecard,  { frame: 2, framescore: 39, type: "spare", rolls: [4,6,"/"]}
    assert_includes @game.scorecard,  { frame: 3, framescore: 48, type: "open", rolls: [9,0]}
    # puts @game.scorecard
  end

  def test_perfect
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
    expected_hash = { frame: 1, framescore: 30, type: "strike", rolls: [10,"X"]}
    assert_includes @game.scorecard, expected_hash

    expected_hash = { frame: 10, framescore: 300, type: "strike", rolls: [10,"X"]}
    assert_includes @game.scorecard, expected_hash
    # puts @game.scorecard
  end

  def test_scorecard_open
    assert_equal [], @game.scorecard
    @game.roll(5)
    assert_equal 5, @game.score
    expected_hash = { frame: 1, framescore: 5, type: "open", rolls: [5,0]}
    assert_includes @game.scorecard, expected_hash
  end

  def test_scorecard_rolls
    complete_frame(4,5)
    @game.score
    assert_includes @game.scorecard, { frame: 1, framescore: 9, type: "open", rolls: [4,5]}
  end

  def test_strike_in_tenth
    roll_many(18, 0)
    strike # strike in 10th get 2 bonus balls | spare in 10th gets 1 bonus ball
    strike
    strike
    assert_equal 30, @game.score
    # assert_includes @game.scorecard, { frame: "10_bonus_1", framescore: "", type: "strike", rolls: []}
    # puts @game.scorecard  # DISPLAY bonus rolls in 10th...
  end



  private
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end
  def complete_frame(roll1,roll2)
    @game.roll(roll1)
    @game.roll(roll2)
  end
  def strike
    @game.roll(Game::PINS)
  end
end