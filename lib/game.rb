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
			if @rolls.fetch(fi,0) == PINS #strike! 
				result += PINS + @rolls.fetch(fi + 1,0) + @rolls.fetch(fi + 2,0)
				fi += 1
			elsif @rolls.fetch(fi,0) + @rolls.fetch(fi + 1,0) == PINS #spare
				result += PINS + @rolls.fetch(fi + 2,0) #sparebonus
				fi += 2
			else
				result += @rolls.fetch(fi,0) + @rolls.fetch(fi + 1, 0)
				fi += 2
			end
			
		end
		result
	end
end