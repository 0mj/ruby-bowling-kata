require 'minitest/autorun'
require_relative '../lib/game'


class GameTest < MiniTest::Test

  def setup
    @game = Game.new
  end

  def test_game_exists
    assert_instance_of Game, @game
  end

  # gutter game
  def test_gutter_game
    roll_many(20,0)
    assert_equal 0, @game.score
  end

  # kid bowler rolls [1,3][2,2] and 16 gutters must score 8
  def test_kid_bowler
    roll_frame(1,3)
    roll_frame(2,2)
    roll_many(16,0)
    assert_equal 8, @game.score
  end

  # test rolling a spare. Spare bowler rolls [9,1][8,1] 16 gutters 
  def test_spare
    roll_frame(9,1) #spare! frame1: 10 + 8 = 18
    roll_frame(8,1) # frame2: 18 + 8 + 1   = 27
    roll_many(16,0) 
    assert_equal 27, @game.score
  end

  # rolls strike [10][3,4] 16 gutters must score  24
  def test_strike
    @game.roll(10)
    roll_frame(3,4)
    roll_many(16,0)
    assert_equal 24, @game.score
  end


  # baller bowler throws a perfect game which is 12 strikes in a a ROW!!
  def test_perfect_game
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
  end


  private
  def roll_frame(r1, r2)
    @game.roll(r1)
    @game.roll(r2)
  end

  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

end 