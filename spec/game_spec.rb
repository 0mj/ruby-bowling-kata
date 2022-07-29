# frozen_string_literal: true
require_relative "../lib/game"
RSpec.describe Game do
  # test 1 gutter game
  it "20 rolls of 0 must score 0" do
    game = Game.new
    20.times do
      game.roll(0)
    end
    expect(game.score).to eq(0)
  end

end
