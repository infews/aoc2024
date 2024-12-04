# frozen_string_literal: true

require "rspec"
module Aoc2024::Day04
  RSpec.describe PuzzlePartOne do
    context "part one" do
      context "with test data" do
        it "solves correctly" do
          puzzle = PuzzlePartOne.from("spec/data/day04_test.txt")
          expect(puzzle.solution).to eq(18)
        end
      end

      context "with real data" do
        it "solves correctly" do
          puzzle = PuzzlePartOne.from("spec/data/day04.txt")
          expect(puzzle.solution).to eq(2447)
        end
      end
    end
  end

  RSpec.describe PuzzlePartTwo do
    context "part one" do
      context "with test data" do
        it "solves correctly" do
          puzzle = PuzzlePartTwo.from("spec/data/day04_test.txt")
          expect(puzzle.solution).to eq(9)
        end
      end

      context "with real data" do
        it "solves correctly" do
          puzzle = PuzzlePartTwo.from("spec/data/day04.txt")
          expect(puzzle.solution).to eq(1868)
        end
      end
    end
  end
end
