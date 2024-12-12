# frozen_string_literal: true

require "rspec"
module Aoc2024::Day02
  RSpec.describe Puzzle do
    context "part one" do
      context "with test data" do
        it "solves correctly" do
          puzzle = Puzzle.from("spec/data/day02_test.txt")
          expect(puzzle.solution).to eq(2)
        end
      end

      context "with real data" do
        it "solves correctly" do
          puzzle = Puzzle.from("spec/data/day02.txt")
          expect(puzzle.solution).to eq(490)
        end
      end
    end

    context "part two" do
      context "with test data" do
        it "solves correctly" do
          puzzle = Puzzle.from("spec/data/day02_test.txt")
          expect(puzzle.solution_with_dampers).to eq(4)
        end
      end

      context "with real data" do
        it "solves correctly" do
          puzzle = Puzzle.from("spec/data/day02.txt")
          expect(puzzle.solution_with_dampers).to eq(536)
        end
      end
    end
  end
end
