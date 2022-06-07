# frozen_string_literal: true

require_relative "../lib/game"

RSpec.describe Game do
  let(:game) { Game.new }
  it "Rolling 20 rolls of 0 must have a score of 0" do
    roll_many(20, 0)
    expect(game.score).to eq(0)
  end

  it "Rolling 10 rolls of 0 and 10 rolls of 1 must have a score of 10" do
    roll_many(10, 0)
    roll_many(10, 1)
    expect(game.score).to eq(10)
  end

  it "Rolling 5, 5, 3 followed by 17 rolls of 0 mut have a score of 16" do
    game.roll(5)
    game.roll(5)
    game.roll(3)
    roll_many(17, 0)
    expect(game.score).to eq(16)
  end
end

def roll_many(rolls, pins)
  rolls.times do
    game.roll(pins)
  end
end
