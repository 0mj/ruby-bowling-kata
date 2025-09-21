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
		fi = 0 #frame index
		result = 0

		FRAMES.times do
			if strike?(fi) 
				result += strike_bonus(fi)
				fi += 1
			elsif spare?(fi)
				result += spare_bonus(fi)
				fi += 2
			else
				result += open_frame(fi)
				fi += 2
			end
			
		end
		result
	end

	private
	def strike?(fi)
		@rolls.fetch(fi,0) == PINS #strike!
	end
	def strike_bonus(fi)
		PINS + @rolls.fetch(fi + 1,0) + @rolls.fetch(fi + 2,0)
	end
	def spare?(fi)
		@rolls.fetch(fi,0) + @rolls.fetch(fi + 1,0) == PINS #spare
	end
	def spare_bonus(fi)
		PINS + @rolls.fetch(fi + 2,0) #sparebonus
	end
	def open_frame(fi)
		@rolls.fetch(fi,0) + @rolls.fetch(fi + 1, 0)
	end
end