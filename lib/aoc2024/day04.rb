# frozen_string_literal: true

module Aoc2024
  module Day04
    class Puzzle
      def self.from(filename)
        new(input: File.read(filename)
                       .split("\n"))
      end

      def initialize(input:)
        @count = 0
        @input = input.map { |line| line.split("") }
        @size = @input.size

        find_xs
        count_xmas
      end

      def solution
        @count
      end

      def find_xs
        @xs = []
        @input.each_with_index do |line, row|
          line.each_with_index do |char, col|
            @xs << [row, col] if char == "X"
          end
        end
      end

      def count_xmas
        @xs.each do |coords|
          row = coords.first
          col = coords.last

          if col + 3 < @size
            @count += 1 if xmas? east_of(row, col)
          end

          if row + 3 < @size && col + 3 < @size
            @count += 1 if xmas? south_east_of(row, col)
          end

          if row + 3 < @size
            @count += 1 if xmas? south_of(row, col)
          end

          if row + 3 < @size && col - 3 >= 0
            @count += 1 if xmas? south_west_of(row, col)
          end

          if col - 3 >= 0
            @count += 1 if xmas? west_of(row, col)
          end

          if row - 3 >= 0 && col - 3 >= 0
            @count += 1 if xmas? north_west_of(row, col)
          end

          if row - 3 >= 0
            @count += 1 if xmas? north_of(row, col)
          end

          if row - 3 >= 0 && col + 3 < @size
            @count += 1 if xmas? north_east_of(row, col)
          end
        end
      end

      private
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