require 'minitest/autorun'
require_relative '../lib/game'


class GameTest < Minitest::Test # MiniTest module. Test is the class within the MiniTest module
  def setup
    @game = Game.new
  end

  def test_game_class_exists
    
    assert_instance_of Game, @game
  end

  # 20 rolls of zero must score 0
  def test_gutter_game
    
    roll_many(20,0)
    assert_equal 0, @game.score
  end

  # ten rolls of one and ten rolls of zero must score 10
  def test_ten_one_zero
    roll_many(10,0)
    roll_many(10,1)
    assert_equal 10, @game.score
  end

  # test spare 
  # roll 9 1 9 & 17 gutters must score 28
  def test_spare
    roll_two(9,1) #spare
    @game.roll(9) #bonus ball added to previous frame score
    assert_equal 28, @game.score
  end

  # two spares in a row
  def test_spare_spare_open
    roll_two(8,1)   # 9           = 9
    roll_two(5,5)   # 9 + 10 + 4  = 23
    roll_two(4,6)   # 23 + 10 + 1 = 34
    roll_two(1,0)   # 34 + 1      = 35
    roll_many(12,0)
    assert_equal 35, @game.score
  end

  # test strike.  Roll 10, 3,4, and 16 gutters must score 24
  def test_strike
    @game.roll(Game::PINS)
    roll_two(3,4)
    assert_equal 24, @game.score
  end

  # perfect game 12 strikes must score 300
  def test_perfect_game
    roll_many(12, Game::PINS)
  end

  # forgot to start a new scorecard..
  # what stops bowler from continuing to throw ? #score method ;) 
  def test_too_many_rolls
    roll_many(200, 1)
    assert_equal 20, @game.score
  end

  # bowler doesn't trust result wants to see each roll
  def test_frame_number
    roll_many(20,1)
    assert_equal [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], @game.rolls
  end

  private
  
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

  def roll_two(r1, r2)
    @game.roll(r1)
    @game.roll(r2)
  end
end