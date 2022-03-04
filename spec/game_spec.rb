# frozen_string_literal: true

require_relative "../lib/game"
RSpec.describe Game do
  let(:game) { Game.new }

  # 1
  it "20 rolls of 0 has a score of 0" do
    roll_many(20, 0)
    expect(game.score).to eq(0)
  end

  # 2
  it "10 rolls of 0 & 10 rolls of 1 has a score of 10" do
    roll_many(10, 0)
    roll_many(10, 1)
    expect(game.score).to eq(10)
  end

  # 3
  it "Rolling 5, 5, 3 followed by 17 rolls of 0 has a score of 16" do
    game.roll(5)
    game.roll(5)
    game.roll(3)
    roll_many(17, 0)
    expect(game.score).to eq(16)
  end

  def roll_many(rolls, pins)
    rolls.times do
      game.roll(pins)
    end
  end
end
