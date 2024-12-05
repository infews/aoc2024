# frozen_string_literal: true

require "rspec"
module Aoc2024::Day05
  RSpec.describe "Solution" do
    context "part one" do
      describe Ruleset do
        let(:ruleset) { Ruleset.new(rules: [[47, 53]]) }

        describe "#valid_with?" do
          context "when the update has no pages" do
            it "is true" do
              expect(ruleset.valid_with?).to eq(true)
              expect(ruleset.valid_with?([])).to eq(true)
            end
          end
          context "when the update has no pages that match in the ruleset" do
            it "is true" do
              expect(ruleset.valid_with?([75, 29, 13])).to eq(true)
            end
          end
          context "when the update has pages that match a page, but has no other pages that match" do
            it "is true" do
              expect(ruleset.valid_with?([47, 1, 2])).to eq(true)
            end
          end
          context "when the update has pages that match a page, all its rules match" do
            it "is true" do
              expect(ruleset.valid_with?([47, 1, 53])).to eq(true)
            end
          end
          context "when the update has pages that match a page, and one fails" do
            it "is false" do
              expect(ruleset.valid_with?([53, 4, 5, 47])).to eq(false)
            end
          end
        end
      end

      describe Update do
        let(:update) { Update.new(pages: [75, 47, 61, 53, 29]) }

        it "returns its middle page" do
          expect(update.middle).to eq(61)
        end
      end

      context "with test data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from(rules: "spec/data/day05_test_rules.txt",
            updates: "spec/data/day05_test_updates.txt")
          expect(puzzle.solution).to eq(143)
        end
      end

      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from(rules: "spec/data/day05_rules.txt",
            updates: "spec/data/day05_updates.txt")
          expect(puzzle.solution).to eq(5129)
        end
      end
    end

    # context "part two" do
    #   context "with test data" do
    #     it "solves correctly" do
    #       puzzle = Puzzle.from("spec/data/day04_test.txt")
    #       expect(puzzle.solve_part_two).to eq(9)
    #     end
    #   end
    #
    #   context "with real data" do
    #     it "solves correctly" do
    #       puzzle = Puzzle.from("spec/data/day04.txt")
    #       expect(puzzle.solve_part_two).to eq(1868)
    #     end
    #   end
    # end
  end
end
