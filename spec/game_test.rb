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
    roll_many(20, 0)
    assert_equal 0, @game.score
    assert_equal 10, @game.frames.size
    @game.frames.each do |frame|
      assert_equal :open, frame[:type]
    end
  end

  def test_ten_ones_ten_gutters
    roll_many(10, 1)
    roll_many(10, 0)
    assert_equal 10, @game.score
    assert_equal 10, @game.frames.size
    @game.frames.each do |frame|
      assert_equal :open, frame[:type]
    end
  end

  def test_spare
    roll_frame(5, 5) # spare
    roll_frame(9, 0)
    roll_frame(4, 0)
    roll_frame(7, 2)
    roll_many(12, 0)
    assert_equal 41, @game.score
    assert_equal 10, @game.frames.size
    assert_equal :spare, @game.frames[0][:type]
    assert_equal :open, @game.frames[1][:type]
  end

  def test_strike
    @game.roll(Game::PINS)
    roll_frame(8, 1)
    roll_many(16, 0)
    assert_equal 28, @game.score
    assert_equal 10, @game.frames.size
    assert_equal :strike, @game.frames[0][:type]
    assert_equal :open, @game.frames[1][:type]
  end

  def test_perfect_game
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
    assert_equal 10, @game.frames.size
    @game.frames.each do |frame|
      assert_equal :strike, frame[:type]
    end
  end

  def test_all_spares
    10.times do
      roll_frame(5, 5)
    end
    @game.roll(5)  # Extra ball for the spare in the 10th frame
    assert_equal 150, @game.score
    assert_equal 10, @game.frames.size
    @game.frames.each do |frame|
      assert_equal :spare, frame[:type]
    end
  end

  def test_random_game
     10.times do
       roll1 = rand(0..10)
       if roll1 == 10
         @game.roll(roll1)
       else
        roll2 = rand(0..(10 - roll1))
        @game.roll(roll1)
        @game.roll(roll2)
       end
     end
    puts "Rolls for this game: #{@game.rolls}"
    puts "Frames for this game: #{@game.frames.inspect}"
    puts "Complete game score: #{@game.score}"
    assert_equal 10, @game.frames.size
    assert @game.score >= 0
    assert @game.score <= 300
  end

  private

  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

  def roll_frame(r1, r2)
    @game.roll(r1)
    @game.roll(r2)
  end
end
