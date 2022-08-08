# frozen_string_literal: true

require_relative "../lib/game"

RSpec.describe Game do
  let(:game) { Game.new }

  # gutter game
  it "Rolling 20 rolls of 0 must score 0" do
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end

  # nearly impossible 10 zeros and 10 ones
  it "Rolling 10 rolls of 0 and 10 rolls of 1 must score 10" do
    10.times do
      game.roll(0)
    end
    10.times do
      game.roll(1)
    end
    expect(game.score).to eq(10)
  end
end
