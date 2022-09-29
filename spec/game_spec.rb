# frozen_string_literal: true

require_relative "../lib/game"

RSpec.describe Game do
  it "Rolling 20 rolls of 0 must score 0" do
    game = Game.new
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end

  it "Rolling 10 rolls of 1 and 10 rolls of 0 must score 10" do
    game = Game.new
    10.times do
      game.roll(1)
    end
    10.times do
      game.roll(0)
    end

    expect(game.score).to eq(10)
  end
end
