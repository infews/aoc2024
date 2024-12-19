# frozen_string_literal: true

require "rspec"
module Aoc2024::Day06
  RSpec.describe Puzzle do
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
          expect(puzzle.unique_visits).to eq(5329)
        end
      end
    end

    context "part two" do
      context "with test data" do
        describe "#find_obstacle_to_guard_right" do
          let(:puzzle) { Puzzle.from("spec/data/day06_test.txt") }
          before { puzzle.new_obstacles_count }

          it "finds an obstacle when moving left" do
            expect(puzzle.find_obstacle_to_guard_right(6, 4, :left)).to eq([0, 4])
          end
          it "finds an obstacle when moving down" do
            expect(puzzle.find_obstacle_to_guard_right(6, 6, :down)).to eq([6, 1])
          end
          it "finds an obstacle when moving right" do
            expect(puzzle.find_obstacle_to_guard_right(7, 6, :right)).to eq([9, 6])
          end
          it "finds an obstacle when moving up" do
            expect(puzzle.find_obstacle_to_guard_right(4, 4, :up)).to eq([4, 7])
          end
        end

        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day06_test.txt")
          expect(puzzle.new_obstacles_count).to eq(6)
        end
      end
      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from("spec/data/day06.txt")
          expect(puzzle.new_obstacles_count).not_to eq(508)
        end
      end
    end
  end
end
