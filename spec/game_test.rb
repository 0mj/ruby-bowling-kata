require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end

  def test_gutters
    20.times do
     @game.roll(0)
    end 
    assert_equal 0, @game.score
  end

  # bowler rolls 3,3  4,4  5,1  14x gutters must score 20
  def test_no_bonuses
    roll_frame(3,3)
    roll_frame(4,4)
    roll_frame(5,1)
    roll_gutters(14)
    assert_equal 20, @game.score
  end

  # bowler rolls 9,1  SPARE followed by 9,0  16x gutters must score 28
  def test_spare
    roll_frame(9,1) #spare!
    roll_frame(9,0)
    roll_gutters(16)
    assert_equal 28, @game.score
  end

  # bowler rolls strike followed by 9,0  8,1 14x gutters must score 37
  def test_strike
    @game.roll(Game::PINS) #19
    roll_frame(9,0)        #28   
    roll_frame(8,1)        #37 
    roll_gutters(14,0)
    assert_equal 37, @game.score
  end

  # bowler rolls 12x strikes in a row must score 300
  def test_perfect_game
    roll_gutters(12, Game::PINS) #thems strikes
    assert_equal 300, @game.score
  end


  private 
  def roll_frame(roll_1, roll_2)
    @game.roll(roll_1)
    @game.roll(roll_2)
  end
  def roll_gutters(rolls, pins = 0)
    rolls.times do
      @game.roll(pins)
    end
  end
end 