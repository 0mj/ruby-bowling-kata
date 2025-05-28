require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
    assert_equal [], @game.card
  end

  def test_gutter_game
    roll_many_of_same(20, 0)
    assert_equal 0, @game.score
  end

  def test_tenOne_tenZero
    roll_many_of_same(10, 0)
    roll_many_of_same(10, 1)
    assert_equal 10, @game.score
  end

  def test_spare
    roll_two(9, 1)
    @game.roll(7)
    roll_many_of_same(17,0)
    assert_equal 24, @game.score
  end

  def test_strike
    strike
    roll_two(9,0)
    roll_many_of_same(16,0)
    assert_equal 28, @game.score
  end

  def test_perfect_game
    roll_many_of_same(12, Game::PINS)
    assert_equal 300, @game.score
  end
  def test_card_strike
    strike
    @game.score
    assert @game.card.any? { |f| f[:frame] == 1 && f[:type] == "STRIKE" }
  end

  def test_complete_card
    roll_many_of_same(20,0)
    @game.score
    assert @game.card.any? { |f| f[:frame] == 10 && f[:type] == "OPEN" }
  end

  

  # Did the bowler get a spare or strike in the tenth?
  def test_tenth_frame_is_strike
    roll_many_of_same(18,0)
    strike
    @game.score
    assert @game.tenth_frame_strike?
  end

  def test_tenth_frame_bonus_rolls_added
    roll_many_of_same(10, Game::PINS)
    roll_two(4,4)
    assert_equal 282, @game.score
  end

  def print_random_card
    Game::FRAMES.times do 
      r1 = rand(0..9)
      r1 <= 7 ? r2 = 3 : r2 = 1
      roll_two(r1, r2)
      print "|#{r1},#{r2}"
    end
    print "|TOTAL=#{@game.score}\n" 
  end

  private
  def roll_many_of_same(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end
  def roll_two(r1, r2)
    @game.roll(r1)
    @game.roll(r2)
  end
  def strike
    @game.roll(Game::PINS)
  end
end