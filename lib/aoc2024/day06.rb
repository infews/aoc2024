# frozen_string_literal: true

module Aoc2024
  module Day06
    class Puzzle
      NEXT_DIR = { up: :right, right: :down, down: :left, left: :up }

      NEXT_ROW = { up: -1, right: 0, down: 1, left: 0 }

      NEXT_COL = { up: 0, right: 1, down: 0, left: -1 }

      def self.from(filename)
        new(map: File.read(filename, chomp: true)
                     .split("\n")
                     .map { |line| line.chars })
      end

      def initialize(map:)
        @map = map
        @obstacles = []
        @guard_row, @guard_col = find_guard(@map)
        @guard_dir = :up
      end

      def unique_visits
        predict
        @map.flatten.join.scan("X").size
      end

      def new_obstacles_count
        predict
        @obstacles.uniq.size
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
          turn if direct_obstacle?
          check_for_loop_obstacle
          mark_and_move
        end
      end

      def on_map(row, col)
        row >= 0 && row < @map.size && col >= 0 && col < @map.size
      end

      def turn
        @guard_dir = NEXT_DIR[@guard_dir]
      end

      def next_position(row, col, direction)
        [row + NEXT_ROW[direction],
         col + NEXT_COL[direction]]
      end

      def direct_obstacle?
        row, col = next_position(@guard_row, @guard_col, @guard_dir)
        if on_map(row, col)
          @map[row][col] == "#"
        end
      end

      def mark_and_move
        return unless on_map(@guard_row, @guard_col)

        @map[@guard_row][@guard_col] = "X"
        @guard_row, @guard_col = next_position(@guard_row, @guard_col, @guard_dir)
      end

      def check_for_loop_obstacle
        seen_row, seen_col = next_position(@guard_row, @guard_col, @guard_dir)
        return unless on_map(seen_row, seen_col)

        look_for_loop = if @guard_dir == :up
                          seen_col.upto(@map.size - 1).map { |i| @map[seen_row][i] }
                        elsif @guard_dir == :down
                          seen_col.downto(0).map { |i| @map[seen_row][i] }
                        elsif @guard_dir == :left
                          seen_row.downto(0).map { |i| @map[i][seen_col] }
                        else
                          # @guard_dir == :right
                          seen_row.upto(@map.size - 1).map { |i| @map[i][seen_col] }
                        end

        look = look_for_loop.join
        if look.match(/XX#/)
          obs_row, obs_col = next_position(seen_row, seen_col, @guard_dir)
          @obstacles << [obs_row, obs_col]
        end
      end
    end
  end
end
