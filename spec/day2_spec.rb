# frozen_string_literal: true

require "rspec"
module Aoc2024::Day2
  RSpec.describe Puzzle1 do
    context "with test data" do
      it "solves correctly" do
        puzzle = Puzzle1.from("spec/data/input_0201_test.txt")
        expect(puzzle.solution).to eq(2)
      end
    end

    context "with real data" do
      it "solves correctly" do
        puzzle = Puzzle1.from("spec/data/input_0201.txt")
        expect(puzzle.solution).to eq(490)
      end
    end
  end
end
