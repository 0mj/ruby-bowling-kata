class Bowling

	FRAMES = 10
	PINS   = 10	
	

	def initialize
		@rolls = []
	end

	def roll(pins)
		@rolls << pins
	end


	def score
		result = 0
		frame_index = 0

		FRAMES.times do # no. frames in game ;)
			if strike?(frame_index)
				result += PINS + strike_bonus(frame_index)
				frame_index += 1

			elsif spare?(frame_index)
				result += PINS + spare_bonus(frame_index)
				frame_index += 2

			else 
				result += @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) 
				frame_index += 2
			end
			
		end
	    result
	end


	private
	
	# extract the spare logic. Create an intention revealing predicate method. Ensure no failures.
	def spare?(frame_index)
		@rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == PINS
	end

	def spare_bonus(frame_index)
		@rolls.fetch(frame_index + 2, 0)
	end

	def strike?(frame_index)
		@rolls.fetch(frame_index) == PINS
	end

	def strike_bonus(frame_index)
		@rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0)
	end

end