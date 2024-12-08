# frozen_string_literal: true

require "rspec"
module Aoc2024::Day07
  RSpec.describe "Solution" do
    context "part one" do
      context "with test data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day07_test.txt")
          expect(puzzle.solve_part_one).to eq(3749)
        end
      end

      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day07.txt")
          expect(puzzle.solve_part_one).to eq(945512582195)
        end
      end
    end

    context "part two" do
      context "with test data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day07_test.txt")
          expect(puzzle.solve_part_two).to eq(11387)
        end
      end

      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day07.txt")
          expect(puzzle.solve_part_two).to eq(271691107779347)
        end
      end
    end
  end
end
