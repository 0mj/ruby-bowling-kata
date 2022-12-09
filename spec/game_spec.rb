# frozen_string_literal: true
require_relative "../lib/game"
RSpec.describe Game do
  
  # 1 gutter game
  it "rolling 20 rolls of 0 must score 0" do
    game = Game.new
    20.times do
      game.roll(0)
    end
  end
  
end
