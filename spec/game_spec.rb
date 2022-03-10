# frozen_string_literal: true

require_relative "../lib/game"
# 0 create files
RSpec.describe Game do
  # 1
  it "20 rolls of 0 has a score of 0" do
    game = Game.new
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end
end
