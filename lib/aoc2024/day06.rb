# frozen_string_literal: true

module Aoc2024
  module Day06

    class Puzzle
      DIR = {
        up: :right,
        right: :down,
        down: :left,
        left: :up
      }

      def self.from(filename)
        new(map: File.read(filename, chomp: true)
                     .split("\n")
                     .map { |line| line.chars }
        )
      end

      def initialize(map:)
        @map = map
        @guard_row, @guard_col = find_guard(@map)
        @guard_dir = :up
      end

      def unique_visits
        predict
        @map.flatten.join.scan(/X/).size
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
        row, col = if @guard_dir == :up
                     [@guard_row - 1, @guard_col]
                   elsif @guard_dir == :right
                     [@guard_row, @guard_col + 1]
                   elsif @guard_dir == :down
                     [@guard_row + 1, @guard_col]
                   else
                     # @guard_dir == :left
                     [@guard_row, @guard_col - 1]
                   end

        if !on_map(row, col)
          "O"
        else
          @map[row][col]
        end
      end

      def mark_and_move
        return unless on_map(@guard_row, @guard_col)

        @map[@guard_row][@guard_col] = "X"
        if @guard_dir == :up
          @guard_row -= 1
        elsif @guard_dir == :right
          @guard_col += 1
        elsif @guard_dir == :down
          @guard_row += 1
        else
          # @guard_dir == :left
          @guard_col -= 1
        end
      end
    end
  end
end
