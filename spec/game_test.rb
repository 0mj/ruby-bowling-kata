require 'minitest/autorun'
require_relative '../lib/game'

class TestGame < MiniTest::Test

  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end

  # Gutter game. 20 rolls of zero must score zero
  def test_gutter_game
    20.times do
      @game.roll(0)
    end
    assert_equal 0, @game.score
  end

  # 10 gutter balls & 10 rolls of 1 must score 10
  def test_ten_gutter_ten_one
    roll_many(10,0)
    roll_many(10,1)
    assert_equal 10, @game.score
  end

  
  def test_spare
    roll_spare
    @game.roll(3)
    assert_equal 16, @game.score
  end

  def roll_many(rolls, pins)
    rolls.times do 
      @game.roll(pins)
    end
  end

  def roll_spare
    roll_many(2,5)
  end




end