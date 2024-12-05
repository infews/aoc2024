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
          expect(puzzle.valid_updates_middle_sums).to eq(143)
        end
      end

      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from(rules: "spec/data/day05_rules.txt",
            updates: "spec/data/day05_updates.txt")
          expect(puzzle.valid_updates_middle_sums).to eq(5129)
        end
      end
    end

    context "part two" do
      describe Update do
        describe "#make_valid_with" do
          let(:ruleset) { Ruleset.from("spec/data/day05_test_rules.txt") }
          context "when the update is already valid" do
            it "has equivalent pages" do
              update = Update.new(pages: [75, 47, 61, 53, 29])
              update.make_valid_with! ruleset
              expect(update.pages).to eq([75, 47, 61, 53, 29])
            end
          end

          context "when the update is invalid" do
            context "when one fix is all that's required" do
              it "repairs the pages" do
                update = Update.new(pages: [75, 97, 47, 61, 53])
                update.make_valid_with! ruleset
                expect(update.pages).to eq([97, 75, 47, 61, 53])
              end
            end
            context "when multiple passes are required" do
              it "repairs the pages" do
                update = Update.new(pages: [97, 13, 75, 29, 47])
                update.make_valid_with! ruleset
                expect(update.pages).to eq([97, 75, 47, 29, 13])
              end
            end
          end
        end
      end

      context "with test data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from(rules: "spec/data/day05_test_rules.txt",
            updates: "spec/data/day05_test_updates.txt")
          expect(puzzle.fixed_updates_middle_sums).to eq(123)
        end
      end

      context "with real data" do
        it "finds the correct solution" do
          puzzle = Puzzle.from(rules: "spec/data/day05_rules.txt",
            updates: "spec/data/day05_updates.txt")
          expect(puzzle.fixed_updates_middle_sums).to eq(4077)
        end
      end
    end
  end
end
