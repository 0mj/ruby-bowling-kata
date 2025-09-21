require 'minitest/autorun'
require_relative '../lib/game'


class Game_Test < Minitest::Test

	def setup
		@game = Game.new
	end

	def test_game_class_exists
		assert_instance_of Game, @game
	end

	def test_gutter_game
		roll_many(20,0)
		assert_equal 0, @game.score
	end

	def test_ten_gutters_ten_ones
		roll_many(10,0)
		roll_many(10,1)
		assert_equal 10, @game.score
	end

	def test_spare
		@game.roll(9)
		@game.roll(1) 
		@game.roll(9)
		roll_many(17,0)
		assert_equal 28, @game.score
	end

	private
	def roll_many(rolls,pins)
		rolls.times do
			@game.roll(pins)
		end
	end
end