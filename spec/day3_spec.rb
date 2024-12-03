# frozen_string_literal: true

require "rspec"
module Aoc2024::Day3
  RSpec.describe Puzzle do
    context "with test data" do
      it "solves correctly" do
        puzzle = Puzzle.from("spec/data/day03_test.txt")
        expect(puzzle.solution).to eq(161)
      end
    end

    context "with real data" do
      it "solves correctly" do
        puzzle = Puzzle.from("spec/data/day03.txt")
        expect(puzzle.solution).to eq(182619815)
      end
    end
  end
end
