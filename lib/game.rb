class Game

	def initialize
		@rolls = []
	end

	def roll(pins)
		@rolls << pins
	end

	def score
		fi = 0 #frame index
		result = 0

		10.times do
			result += if @rolls.fetch(fi,0) + @rolls.fetch(fi + 1,0) == 10 #spare
				10 + @rolls.fetch(fi + 2,0) #sparebonus
			else
				@rolls.fetch(fi,0) + @rolls.fetch(fi + 1, 0)
			end
			fi += 2
		end
		result
	end
end