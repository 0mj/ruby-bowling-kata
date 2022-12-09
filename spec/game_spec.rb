# frozen_string_literal: true

require_relative "../lib/game"
RSpec.describe Game do
  let(:game) { Game.new }
  # 1 gutter game
  it "rolling 20 rolls of 0 must score 0" do
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end

  # 2 Gutters x10 Ones x10 must score 10
  it "rolling 10 rolls of 0 and 10 rolls of 1 must score 10" do
    10.times do
      game.roll(0)
    end
    roll_many(10, 1)
    expect(game.score).to eq(10)
  end
end

def roll_many(rolls, pins)
  rolls.times do
    game.roll(pins)
  end
end
