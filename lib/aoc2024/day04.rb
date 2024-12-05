# frozen_string_literal: true

module Aoc2024
  module Day04
    class Puzzle
      def self.from(filename)
        new(input: File.read(filename)
                       .split("\n"))
      end

      def initialize(input:)
        @input = input.map { |line| line.chars }
        @size = @input.size
      end

      def solve_part_one
        count = 0
        find("X").each do |coords|
          row, col = coords

          if col + 3 < @size
            count += 1 if xmas? east_of(row, col)
          end

          if row + 3 < @size && col + 3 < @size
            count += 1 if xmas? south_east_of(row, col)
          end

          if row + 3 < @size
            count += 1 if xmas? south_of(row, col)
          end

          if row + 3 < @size && col - 3 >= 0
            count += 1 if xmas? south_west_of(row, col)
          end

          if col - 3 >= 0
            count += 1 if xmas? west_of(row, col)
          end

          if row - 3 >= 0 && col - 3 >= 0
            count += 1 if xmas? north_west_of(row, col)
          end

          if row - 3 >= 0
            count += 1 if xmas? north_of(row, col)
          end

          if row - 3 >= 0 && col + 3 < @size
            count += 1 if xmas? north_east_of(row, col)
          end
        end
        count
      end

      def solve_part_two
        count = 0
        find("A").each do |coords|
          row, col = coords

          next if row - 1 < 0 || row + 1 >= @size ||
            col - 1 < 0 || col + 1 >= @size

          corners = @input[row - 1][col - 1] +
            @input[row + 1][col - 1] +
            @input[row - 1][col + 1] +
            @input[row + 1][col + 1]

          count += 1 if /MMSS|SSMM|MSMS|SMSM/.match?(corners)
        end
        count
      end

      private

      def find(value)
        points = []
        @input.each_with_index do |line, row|
          line.each_with_index do |char, col|
            points << [row, col] if char == value
          end
        end
        points
      end

      def north_east_of(row, col)
        @input[row][col] + @input[row - 1][col + 1] + @input[row - 2][col + 2] + @input[row - 3][col + 3]
      end

      def north_of(row, col)
        @input[row][col] + @input[row - 1][col] + @input[row - 2][col] + @input[row - 3][col]
      end

      def north_west_of(row, col)
        @input[row][col] + @input[row - 1][col - 1] + @input[row - 2][col - 2] + @input[row - 3][col - 3]
      end

      def west_of(row, col)
        @input[row][col] + @input[row][col - 1] + @input[row][col - 2] + @input[row][col - 3]
      end

      def south_west_of(row, col)
        @input[row][col] + @input[row + 1][col - 1] + @input[row + 2][col - 2] + @input[row + 3][col - 3]
      end

      def east_of(row, col)
        @input[row][col] + @input[row][col + 1] + @input[row][col + 2] + @input[row][col + 3]
      end

      def south_east_of(row, col)
        @input[row][col] + @input[row + 1][col + 1] + @input[row + 2][col + 2] + @input[row + 3][col + 3]
      end

      def south_of(row, col)
        @input[row][col] + @input[row + 1][col] + @input[row + 2][col] + @input[row + 3][col]
      end

      def xmas?(chars)
        chars == "XMAS"
      end
    end
  end
end
