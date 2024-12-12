# frozen_string_literal: true

require "rspec"
module Aoc2024::Day01
  RSpec.describe Puzzle1 do
    context "with test data" do
      it "solves correctly" do
        puzzle = Puzzle1.from("spec/data/day01_test.txt")
        expect(puzzle.solution).to eq(11)
      end
    end

    context "with real data" do
      it "solves correctly" do
        puzzle = Puzzle1.from("spec/data/day01.txt")
        expect(puzzle.solution).to eq(2285373)
      end
    end
  end

  RSpec.describe Puzzle2 do
    context "with test data" do
      it "solves correctly" do
        puzzle = Puzzle2.from("spec/data/day01_test.txt")
        expect(puzzle.solution).to eq(31)
      end
    end

    context "with real data" do
      it "solves correctly" do
        puzzle = Puzzle2.from("spec/data/day01.txt")
        expect(puzzle.solution).to eq(21142653)
      end
    end
  end
end
