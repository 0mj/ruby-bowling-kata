require 'minitest/autorun'
require_relative '../lib/frame'

class TestFrame < MiniTest::Test

  def setup
    @frame = Frame.new
  end

  def test_frame_exists
    assert_instance_of Frame, @frame
  end

  # just starting game no rolls have been thrown
  def test_new_frame_has_no_rolls
    assert_equal 0, @frame.rolls.size
  end

  # add rolls to frame
  def test_add_roll
    @frame.add_roll(5)
    assert_equal [5], @frame.rolls
  end

  # add 2 rolls to frame
  def test_two_rolls
    @frame.add_roll(4)
    @frame.add_roll(5)
    assert_equal [4, 5], @frame.rolls
  end

  def test_is_strike
    @frame.add_roll(10)
    assert @frame.strike?
  end

  def test_is_spare
    @frame.add_roll(6)
    @frame.add_roll(4)
    assert @frame.spare?
  end

  def test_is_open
    @frame.add_roll(6)
    @frame.add_roll(3)
    assert @frame.open?
  end

  def test_is_complete    
    refute @frame.complete? # While assert passes when its argument is true, refute passes when its argument is false.
    
    @frame.add_roll(3)
    refute @frame.complete?
    
    @frame.add_roll(4)
    assert @frame.complete?
  end

  # def test_strike_is_complete_after_one_roll
  #   frame = Frame.new
  #   frame.add_roll(10)
  #   assert frame.complete?
  # end

end