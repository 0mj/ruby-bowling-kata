# frozen_string_literal: true

require_relative "../lib/game"

RSpec.describe Game do
  it "20 rolls of 0 results in a score of 0" do
    game = Game.new
    20.times do
      game.roll(0)
    end
  end
end
