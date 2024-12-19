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
        @new_obstacles = []
        @obstacles = {}
        @original_pos = find_guard(@map)
        @guard_row = @original_pos[0]
        @guard_col = @original_pos[1]
        @guard_dir = :up
      end

      def unique_visits
        predict
        @map.flatten.join.scan("X").size
      end

      def new_obstacles_count
        predict
        @new_obstacles.uniq.size
      end

      def find_obstacle_to_guard_right(seen_row, seen_col, direction)
        never_seen = [-1, -1]

        case direction
        when :up
          index = seen_col.upto(@map.size - 1)
                          .map { |i| @map[seen_row][i] }
                          .find_index("#")

          index.nil? ? never_seen : [seen_row, seen_col + index]

        when :down
          index = seen_col.downto(0)
                          .map { |i| @map[seen_row][i] }
                          .find_index("#")

          index.nil? ? never_seen : [seen_row, seen_col - index]

        when :left
          index = seen_row.downto(0)
                          .map { |i| @map[i][seen_col] }
                          .find_index("#")

          index.nil? ? never_seen : [seen_row - index, seen_col]

        when :right
          index = seen_row.upto(@map.size - 1)
                          .map { |i| @map[i][seen_col] }
                          .find_index("#")

          index.nil? ? never_seen : [seen_row + index, seen_col]
        end
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
          check_for_new_obstacle
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
        if on_map(row, col) && @map[row][col] == "#"
          if @obstacles[[row, col]]
            @obstacles[[row, col]] << @guard_dir
          else
            @obstacles[[row, col]] = [@guard_dir]
          end
          true
        end
      end

      def mark_and_move
        return unless on_map(@guard_row, @guard_col)

        @map[@guard_row][@guard_col] = "X"
        @guard_row, @guard_col = next_position(@guard_row, @guard_col, @guard_dir)
      end

      def check_for_new_obstacle
        seen_row, seen_col = next_position(@guard_row, @guard_col, @guard_dir)
        return unless on_map(seen_row, seen_col)

        seen_obs = find_obstacle_to_guard_right(seen_row, seen_col, @guard_dir)

        directions_collided = nil
        if (directions_collided = @obstacles.fetch([seen_obs[0], seen_obs[1]], false))
          if directions_collided.include?(NEXT_DIR[@guard_dir])
            new_row, new_col = next_position(seen_row, seen_col, @guard_dir)
            if @obstacles[[new_row, new_col]] != [new_row, new_col]
              @new_obstacles << [new_row, new_col]
            end
          end
        end
      end
    end
  end
end
