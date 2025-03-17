require 'minitest/autorun'
require_relative '../lib/game'

class TestGame < MiniTest::Test

  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end


  # test 1 - gutter game.. 20 rolls of 0 must score 0
  def test_gutters
    roll_many(20, 0)
    assert_equal 0, @game.score
  end

  # test 2 - roll ten zeros and ten ones must score 10
  def test_ten_gutters_ten_ones
    roll_many(10, 1)
    roll_many(10, 0)
    assert_equal 10, @game.score
  end
<<<<<<< Updated upstream

  # test 3 - spare. roll 5,5,3 & 17 gutters must score 16
=======
  
>>>>>>> Stashed changes
  def test_spare
    roll_two(8,2)
    @game.roll(3)
    roll_many(17,0)
    assert_equal 16, @game.score
  end

<<<<<<< Updated upstream
  # test 3.1 - spare. roll 5,5,3, 14gutters 5,5,3 must score 32
  def test_spare_gutters_spare
    roll_spare
    @game.roll(3)
    roll_many(13,0)
    roll_spare
    @game.roll(3)
    roll_many(2,0)
    assert_equal 32, @game.score
  end

  # test 4 - strike. roll 10, 3, 4 & 16 gutters must score 24
  def test_strike
    roll_strike
    @game.roll(3)
    @game.roll(4)
    roll_many(16, 0)
    assert_equal 24, @game.score
  end

  # test 5 perfect game scores 300! 12 strikes!
=======
  def test_strike
    @game.roll(Game::PINS)
    @game.roll(3)
    @game.roll(4)
    roll_many(16,0)
    assert_equal 24, @game.score
  end
>>>>>>> Stashed changes
  def test_perfect_game
    roll_many(12, Game::PINS)
    assert_equal 300, @game.score
  end

<<<<<<< Updated upstream
  # t5.1 roll 16 gutters(8frames), roll strike, strike, strike, strike
=======
  # 0---------------------------------------------

# t5.1 roll 16 gutters(8frames), roll strike, strike, strike, strike
>>>>>>> Stashed changes
  def test_sixteen_gutters_four_strikes
    roll_many(16,0) # 8 frames
    roll_many(4, Game::PINS)
    assert_equal 60, @game.score
  end

  # test 6 roll spare, strike, 16 gutters must score 30
  def test_spare_strike_sixteen_gutters
<<<<<<< Updated upstream
    roll_spare
=======
    roll_two(7,3)
>>>>>>> Stashed changes
    roll_strike
    roll_many(16,0)
    assert_equal 30, @game.score
  end

  
  #| Frame  | 1     | 2     | 3     | 4     | 5     | 6     | 7     | 8     | 9     | 10     |
  #|--------|-------|-------|-------|-------|-------|-------|-------|-------|-------|--------|
  #| Rolls  | 7  2  | 9  /  | X     | X     | 9  0  | 8  /  | 7  /  | X     | 9  0  | X  8  1|
  #| Score  | 9     | 29    | 58    | 77    | 86    | 103   | 123   | 142   | 151   | 170    |
  
  def test_sample_score_card
    @game.roll(7)
    @game.roll(2)

    @game.roll(9)
    @game.roll(1)

    roll_strike
    
    roll_strike
    
    @game.roll(9)
    @game.roll(0)
    
    @game.roll(8)
    @game.roll(2)

    @game.roll(7)
    @game.roll(3)
    
    roll_strike
    
    @game.roll(9)
    @game.roll(0)
    
    roll_strike
    @game.roll(8)
    @game.roll(1)
    assert_equal 170, @game.score
  end

  def test_tenth_frame_strike_out
    roll_many(18,0)
    roll_strike
    roll_strike
    roll_strike
    assert_equal 30, @game.score
  end
<<<<<<< Updated upstream

  def test_tenth_frame_spare
    roll_many(18,0)
    roll_spare
    @game.roll(6)
    assert_equal 16, @game.score
=======
  # spare in the 10th frame gives you one extra ball for bonus
  def test_tenth_frame_spare
    roll_many(18,0)
    roll_two(8,2)
    @game.roll(3)
    assert_equal 13, @game.score
>>>>>>> Stashed changes
  end

  # Rolls: [10, 9,1, 10, 9,1, 10, 9,1, 10, 9,1, 10, 9,1]
  # Score: 200 
  def test_dutch_200
    roll_strike
    @game.roll(9)
    @game.roll(1)
    roll_strike
    @game.roll(9)
    @game.roll(1)
    roll_strike
    @game.roll(9)
    @game.roll(1)
    roll_strike
    @game.roll(9)
    @game.roll(1)
    roll_strike
    @game.roll(9)
    @game.roll(1)
    roll_strike
    assert_equal 200, @game.score
  end


  # Rolls: [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 0]
  # Score: 289
  def test_almost_perfect
    10.times do
      roll_strike
    end
    @game.roll(9)
    @game.roll(0)
    assert_equal 288, @game.score
  end


  # Rolls: [10, | 0,0, | 10, |0,0, |10, | 0,0,| 10, |0,0,| 10, | 0,0]
  # Score: 50
  def test_alternating_strikes_misses
    roll_strike
    roll_many(2,0)
    roll_strike
    roll_many(2,0)
    roll_strike
    roll_many(2,0)
    roll_strike
    roll_many(2,0)
    roll_strike
    roll_many(2,0)
    assert_equal 50, @game.score
  end
<<<<<<< Updated upstream


  private

=======
  # 0---------------------------------------------

  private
>>>>>>> Stashed changes
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end

  def roll_two(roll_one, roll_two)
    @game.roll(roll_one)
    @game.roll(roll_two)
  end
  def roll_strike
    @game.roll(Game::PINS)
  end

<<<<<<< Updated upstream
  def roll_strike
    @game.roll(Game::PINS)
  end

=======
>>>>>>> Stashed changes
end