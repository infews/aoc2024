# frozen_string_literal: true

module Aoc2024
  module Day06
    class Puzzle
      DIR = {up: :right, right: :down, down: :left, left: :up}

      NEXT_ROW = {up: -1, right: 0, down: 1, left: 0}

      NEXT_COL = {up: 0, right: 1, down: 0, left: -1}

      def self.from(filename)
        new(map: File.read(filename, chomp: true)
                     .split("\n")
                     .map { |line| line.chars })
      end

      def initialize(map:)
        @map = map
        @guard_row, @guard_col = find_guard(@map)
        @guard_dir = :up
      end

      def unique_visits
        predict
        @map.flatten.join.scan("X").size
      end

      private

      def find_guard(map)
        pos = @map.flat_map.with_index { |row, j|
          row.collect.with_index { |char, i|
            [char, [j, i]]
          }
        }.to_h["^"]
        [pos.first, pos.last]
      end

      def predict
        while on_map(@guard_row, @guard_col)
          turn if look == "#"
          mark_and_move
        end
      end

      def on_map(row, col)
        row >= 0 && row < @map.size && col >= 0 && col < @map.size
      end

      def turn
        @guard_dir = DIR[@guard_dir]
      end

      def look
        row = @guard_row + NEXT_ROW[@guard_dir]
        col = @guard_col + NEXT_COL[@guard_dir]
        if on_map(row, col)
          @map[row][col]
        end
      end

      def mark_and_move
        return unless on_map(@guard_row, @guard_col)

        @map[@guard_row][@guard_col] = "X"
        @guard_row += NEXT_ROW[@guard_dir]
        @guard_col += NEXT_COL[@guard_dir]
      end
    end
  end
end
