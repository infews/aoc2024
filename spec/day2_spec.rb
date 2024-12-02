# frozen_string_literal: true

require "rspec"
module Aoc2024::Day2
  RSpec.describe Puzzle do
    context "with test data" do
      it "solves correctly" do
        puzzle = Puzzle.from("spec/data/input_0201_test.txt")
        expect(puzzle.solution).to eq(2)
      end
    end

    context "with real data" do
      it "solves correctly" do
        puzzle = Puzzle.from("spec/data/input_0201.txt")
        expect(puzzle.solution).to eq(490)
      end
    end
  end

  RSpec.describe Puzzle do
    context "with test data" do
      it "solves correctly" do
        puzzle = Puzzle.from("spec/data/input_0201_test.txt")
        expect(puzzle.solution_with_dampers).to eq(4)
      end
    end

    context "with real data" do
      it "solves correctly" do
        puzzle = Puzzle.from("spec/data/input_0201.txt")
        expect(puzzle.solution_with_dampers).to eq(536)
      end
    end
  end
end
