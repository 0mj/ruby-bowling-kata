# frozen_string_literal: true

require_relative "../lib/game"
RSpec.describe Game do
  # 1
  it "20 rolls of 0 has a score of 0" do
    game = Game.new
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end

  # 2
  it "10 rolls of 0 & 10 rolls of 1 has a score of 10" do
    game = Game.new
    10.times do
      game.roll(0)
    end
    10.times do
      game.roll(1)
    end
    expect(game.score).to eq(10)
  end
end
