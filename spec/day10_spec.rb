# frozen_string_literal: true

require "rspec"

module Aoc2024::Day10
  RSpec.describe LavaMap do
    context "part one" do

      describe ".from" do
        context "for example 1" do
          let(:lavamap) { LavaMap.from("spec/data/day10_test1.txt") }
          it "finds the trail count" do
            expect(lavamap.trailheads.size).to eq(1)
          end
          it "has the correct trailheads" do
            expect(lavamap.trailheads.first).to eq([0,3])
          end
          it "has the correct score" do
            expect(lavamap.score).to eq(2)
          end
        end

        context "for example 2" do
          let(:lavamap) { LavaMap.from("spec/data/day10_test2.txt") }
          it "finds the trail count" do
            expect(lavamap.trailheads.size).to eq(1)
          end
          it "has the correct trailheads" do
            expect(lavamap.trailheads.first).to eq([0,3])
          end
          it "has the correct score" do
            expect(lavamap.score).to eq(4)
          end
        end

        context "for example 3" do
          let(:lavamap) { LavaMap.from("spec/data/day10_test3.txt") }
          it "finds the trail count" do
            expect(lavamap.trailheads.size).to eq(2)
          end
          it "has the correct trailheads" do
            expect(lavamap.trailheads[0]).to eq([0,1])
            expect(lavamap.trailheads[1]).to eq([6,5])
          end
          it "has the correct score" do
            expect(lavamap.score).to eq(3)
          end
        end
        context "for example 4" do
          let(:lavamap) { LavaMap.from("spec/data/day10_test4.txt") }
          it "finds the trail count" do
            expect(lavamap.trailheads.size).to eq(9)
          end
          it "has the correct trailheads" do
            expect(lavamap.trailheads[0]).to eq([0,2])
            expect(lavamap.trailheads[1]).to eq([0,4])
            expect(lavamap.trailheads[2]).to eq([2,4])
            expect(lavamap.trailheads[3]).to eq([4,6])
            expect(lavamap.trailheads[4]).to eq([5,2])
            expect(lavamap.trailheads[5]).to eq([5,5])
            expect(lavamap.trailheads[6]).to eq([6,0])
            expect(lavamap.trailheads[7]).to eq([6,6])
            expect(lavamap.trailheads[8]).to eq([7,1])
          end
          it "has the correct score" do
            expect(lavamap.score).to eq(36)
          end
        end
      end
    end
  end
end
