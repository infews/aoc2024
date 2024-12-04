# frozen_string_literal: true

require "rspec"
module Aoc2024::Day04
  RSpec.describe Puzzle do
    context "part one" do
      context "with test data" do
        it "solves correctly" do
          puzzle = Puzzle.from("spec/data/day04_test.txt")
          expect(puzzle.solution).to eq(18)
        end
      end

      context "with real data" do
        it "solves correctly" do
          puzzle = Puzzle.from("spec/data/day04.txt")
          expect(puzzle.solution).to eq(2447)
        end
      end
    end

    # context "part two" do
    #   context "with test data" do
    #     it "solves correctly" do
    #       puzzle = Puzzle.from_parsing_with_toggle("spec/data/day04_test_p2.txt")
    #       expect(puzzle.solution).to eq(48)
    #     end
    #   end
    #
    #   context "with real data" do
    #     it "solves correctly" do
    #       puzzle = Puzzle.from_parsing_with_toggle("spec/data/day04.txt")
    #       expect(puzzle.solution).to eq(80747545)
    #     end
    #   end
    # end
  end
end
