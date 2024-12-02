# frozen_string_literal: true

require "rspec"
module Aoc2024::Day1
  RSpec.describe Puzzle1 do
    context "with test data" do
      it "solves correctly" do
        puzzle = Puzzle1.from("spec/data/input_0101_test.txt")
        expect(puzzle.solution).to eq(11)
      end
    end

    context "with real data" do
      it "solves correctly" do
        puzzle = Puzzle1.from("spec/data/input_0101.txt")
        expect(puzzle.solution).to eq(2285373)
      end
    end
  end
end
