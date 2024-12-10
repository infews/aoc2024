# frozen_string_literal: true

require "rspec"

module Aoc2024::Day08
  RSpec.describe Puzzle do
    context "part one" do
      context "with test data" do
        let(:puzzle) { Puzzle.from("spec/data/day08_test.txt") }

        it "finds the antennae" do
          antennae = puzzle.antennae
          expect(antennae.keys.size).to eq(2)
          expect(antennae["0"]).to eq([[1, 8], [2, 5], [3, 7], [4, 4]])
          expect(antennae["A"]).to eq([[5, 6], [8, 8], [9, 9]])
        end

        it "finds the antinodes" do
          antinodes = puzzle.antinodes
          expect(antinodes.size).to eq(14)
          expect(antinodes).to include([0,11])
          expect(antinodes).to include([3,2])
          expect(antinodes).to include([5,6])
          expect(antinodes).to include([0,6])
          expect(antinodes).to include([1,3])
          expect(antinodes).to include([4,9])
          expect(antinodes).to include([6,3])
          expect(antinodes).to include([5,1])
          expect(antinodes).to include([2,4])
          expect(antinodes).to include([7,7])
          expect(antinodes).to include([10,10])
          expect(antinodes).to include([7,0])
          expect(antinodes).to include([2,10])
          expect(antinodes).to include([11,10])
        end

        it "finds the correct number of anitnodes" do
          expect(puzzle.antinodes.size).to eq(14)
        end
      end

      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day08.txt")
          expect(puzzle.antinodes.size).to eq(252)
        end
      end
    end
  end
end
