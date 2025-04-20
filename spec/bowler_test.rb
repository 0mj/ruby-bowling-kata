require 'minitest/autorun'
require_relative '../lib/bowler'

class BowlerTest < MiniTest::Test

  def test_bowler_instance
    bowler = Bowler.new
    assert_instance_of Bowler, bowler
  end
end