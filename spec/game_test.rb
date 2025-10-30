require 'minitest/autorun'
require_relative '../lib/game'

class Game_Test < Minitest::Test

	def setup
		@game = Game.new
	end

	def test_game_class_exists
		assert_instance_of Game, @game
	end

	# test throwing 20 gutter balls must score 0
	def test_gutters
		roll_many(20,0)
		assert_equal 0, @game.score
	end

	# rolls 3,4  3,4  and 16 gutters must score 14
	def test_open_frame_bowler
		roll_two(3,4)
		roll_two(3,4)
		roll_many(16,0)
		assert_equal 14, @game.score
	end

	# test spare rolls 9,1  9   and 17 gutters must score 28
	def test_spare
		roll_two(9,1)
		@game.roll(9)
		roll_many(17,0)
		assert_equal 28, @game.score
	end

	# test strike. rolls 10  4,4  and 16 gutters must score 26
	def test_strike
		@game.roll(Game::PINS)
		roll_two(4,4)
		roll_many(16,0)
		assert_equal 26, @game.score
	end

	# test perfect game
	def test_perfect_game
		roll_many(12, Game::PINS)
		assert_equal 300, @game.score
	end

	private

	def roll_many(rolls, pins)
		rolls.times do
			@game.roll(pins)
		end
	end

	def roll_two(roll1,roll2)
		@game.roll(roll1)
		@game.roll(roll2)
	end

end