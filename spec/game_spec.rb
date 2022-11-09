# frozen_string_literal: true

require_relative "../lib/game"
RSpec.describe Game do
  let(:game) {Game.new}
  
  it "Rolling 20 rolls of 0 must score 0" do
    roll_many(20,0)
    expect(game.score).to eq(0)
  end

  it "10 gutter balls & 10 rolls of 1 must score 10" do
    roll_many(10,1)
    roll_many(10,0)
    expect(game.score).to eq(10)
  end

  def roll_many(rolls,pins)
    rolls.times do
      game.roll(pins)
    end
  end
end
