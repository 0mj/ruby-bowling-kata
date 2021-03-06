# frozen_string_literal: true

require_relative "../lib/game"
RSpec.describe Game do
  let(:game) { Game.new }

  # test 1 gutter game
  it "20 rolls of 0 must score 0" do
    roll_many(20, 0)
    expect(game.score).to eq(0)
  end
  # test 2 10 gutters and 10 rolls of 1
  it "10 rolls of 0 and 10 rolls of 1 must score 10" do
    roll_many(10, 0)
    roll_many(10, 1)
    expect(game.score).to eq(10)
  end

  def roll_many(rolls, pins)
    rolls.times do
      game.roll(pins)
    end
  end

  # test 3 picking up spare
  it "Rolling 5, 5, 3 and 17 rolls of 0 must score 16" do
    roll_spare
    game.roll(3)
    roll_many(17, 0)
    expect(game.score).to eq(16)
  end

  def roll_spare
    roll_many(2, 5)
  end

  # test 4 strike
  it "Rolling 10, 3, 4 followed by 16 rolls of 0 must score 24" do
    game.roll(10)
    game.roll(3)
    game.roll(4)
    expect(game.score).to eq(24)
  end

  # test 5 perfect game
  it "Rolling 12 rolls of10 must score 300)" do
    roll_many(12, 10)
    expect(game.score).to eq(300)
  end
end
