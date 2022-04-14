# frozen_string_literal: true

require_relative "../lib/game"
RSpec.describe Game do
  let(:game) { Game.new }
  it "20 rolls of 0 has a score of 0" do
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end

  it "10 rolls of 0 and 10 rolls of 1 has a score of 10" do
    roll_many(10, 0)
    roll_many(10, 1)
    expect(game.score).to eq(10)
  end

  it "Rolling 5,5,3 followed by 17 rolls of 0 must have a score of 16" do
    roll_spare
    game.roll(3)
    roll_many(17, 0)
    expect(game.score).to eq(16)
  end

  it "Rolling 10, 3, 4 followed by 16 rolls of 0 must have a scove of 24" do
    roll_strike
    game.roll(3)
    game.roll(4)
    expect(game.score).to eq(24)
  end

  it "Rolling PERFECT GAME! 12 rolls of 10 must have a score of 300" do
    roll_many(12, 10)
    expect(game.score).to eq(300)
  end
end

def roll_strike
  game.roll(Game::PINS)
end

def roll_spare
  roll_many(2, 5)
end

def roll_many(rolls, pins)
  rolls.times do
    game.roll(pins)
  end
end
