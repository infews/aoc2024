# frozen_string_literal: true

require "rspec"

module Aoc2024::Day09
  RSpec.describe Disk do
    context "part one" do

      describe ".from" do
        context "for example 1" do
          let(:disk) { Disk.from("spec/data/day09_test1.txt") }
          it "builds the correct ID map" do
            expect(disk.id_map.join).to eq("0..111....22222")
          end
          it "saves the index of the first free block" do
            expect(disk.first_free_block_index).to eq(1)
          end
          it "saves the index of the last file" do
            expect(disk.last_file_block_index).to eq(10)
          end
          it "saves the total free space" do
            expect(disk.total_free_space).to eq(6)
          end
        end
        context "for example 2" do
          let(:disk) { Disk.from("spec/data/day09_test2.txt") }

          it "builds the correct ID map" do
            expect(disk.id_map.join).to eq("00...111...2...333.44.5555.6666.777.888899")
          end

          it "saves the index of the first free block" do
            expect(disk.first_free_block_index).to eq(2)
          end

          it "saves the index of the last file" do
            expect(disk.last_file_block_index).to eq(40)

          end
          it "saves the total free space" do
            expect(disk.total_free_space).to eq(14)
          end
        end
      end

      describe "#compact_free_space!" do
        context "for example 1" do
          let(:disk) { Disk.from("spec/data/day09_test1.txt") }

          it "compacts as expected" do
            disk.compact_free_space!
            expect(disk.id_map.join).to eq("022111222......")
          end
        end

        context "for example 2" do
          let(:disk) { Disk.from("spec/data/day09_test2.txt") }

          it "compacts as expected" do
            disk.compact_free_space!
            expect(disk.id_map.join).to eq("0099811188827773336446555566..............")
          end
        end
      end

      describe "#filesystem_checksum" do
        context "for example 2" do
          let(:disk) { Disk.from("spec/data/day09_test2.txt") }

          it "calculates the right value" do
            disk.compact_free_space!
            expect(disk.filesystem_checksum).to eq(1928)
          end
        end

        context "for real data" do
          let(:disk) { Disk.from("spec/data/day09.txt") }

          it "calculates the right value" do
            disk
            disk.compact_free_space!
            expect(disk.filesystem_checksum).to eq(6307275788409)
          end
        end
      end
    end

    context "part two" do
      describe "#defrag_whole_files!" do
        context "for example 2" do
          let(:disk) { Disk.from("spec/data/day09_test2.txt") }

          it "compacts as expected" do
            disk.defrag_whole_files!
            expect(disk.id_map.join).to eq("00992111777.44.333....5555.6666.....8888..")
          end
        end
      end

      describe "#filesystem_checksum" do
        context "for example 2" do
          let(:disk) { Disk.from("spec/data/day09_test2.txt") }

          it "calculates the right value" do
            disk.defrag_whole_files!
            expect(disk.filesystem_checksum).to eq(2858)
          end
        end

        context "for real data" do
          let(:disk) { Disk.from("spec/data/day09.txt") }

          it "calculates the right value" do
            disk
            disk.defrag_whole_files!
            expect(disk.filesystem_checksum).to eq(6307275788409)
          end
        end
      end
    end
  end
end
