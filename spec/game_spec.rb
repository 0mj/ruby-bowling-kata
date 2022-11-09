# frozen_string_literal: true

require_relative "../lib/game"
RSpec.describe Game do
  let(:game) { Game.new }

  it "Rolling 20 rolls of 0 must score 0" do
    roll_many(20, 0)
    expect(game.score).to eq(0)
  end

  it "10 gutter balls & 10 rolls of 1 must score 10" do
    roll_many(10, 1)
    roll_many(10, 0)
    expect(game.score).to eq(10)
  end

  it "Rolling 5, 5, 3, followed by 17 rolls of 0 must have a score of 16" do
    roll_spare
    game.roll(3)
    roll_many(17, 0)
    expect(game.score).to eq(16)
  end

  it "Rolling 10, 3, 4, followed by 16 rolls of 0 must have a score of 24" do
    roll_strike
    game.roll(3)
    game.roll(4)
    roll_many(16, 0)
    expect(game.score).to eq(24)
  end

  it "Rolling 12 rolls of 10 must score 300" do
    roll_many(12, 10)
    expect(game.score).to eq(300)
  end

  def roll_many(rolls, pins)
    rolls.times do
      game.roll(pins)
    end
  end

  def roll_spare
    roll_many(2, 5)
  end

  def roll_strike
    game.roll(Game::PINS)
  end
end
