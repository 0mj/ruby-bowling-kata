class Game

	PINS = 10
	FRAMES = 10

	def initialize
		@rolls = []
	end

	def roll(pins)
		@rolls << pins
	end

	def score
		current_r = 0 # current roll
		result = 0

		FRAMES.times do
			
			if strike?(current_r)
				result += strike_bonus(current_r)
				current_r += 1
			elsif spare?(current_r)
				result += spare_bonus(current_r)
				current_r += 2
			else
				result += open_frame(current_r)
				current_r += 2
			end
			
		end
		result
	end

	private

	def spare?(current_r)
		@rolls.fetch(current_r,0) + @rolls.fetch(current_r + 1,0) == PINS #spare
	end
	def spare_bonus(current_r)
		PINS + @rolls.fetch(current_r + 2,0)
	end
	def open_frame(current_r)
		@rolls.fetch(current_r,0) + @rolls.fetch(current_r + 1,0)
	end
	def strike?(current_r)
		@rolls.fetch(current_r,0) == PINS #strike
	end
	def strike_bonus(current_r)
		PINS +  @rolls.fetch(current_r + 1,0) + @rolls.fetch(current_r + 2,0)	
	end
end