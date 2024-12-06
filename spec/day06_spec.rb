# frozen_string_literal: true

require "rspec"
module Aoc2024::Day06
  RSpec.describe "Solution" do
    context "part one" do

      context "with test data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day06_test.txt")
          expect(puzzle.unique_visits).to eq(41)
        end
      end

      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day06.txt")
          expect(puzzle.unique_visits).to eq(41)
        end
      end
    end
  end
end
