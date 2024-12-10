module Aoc2024
  module Day08
    class Puzzle
      attr_reader :antennae

      def self.from(filename)
        new(input: File.read(filename)
                       .split("\n")
                       .map { |line| line.chars })
      end

      def initialize(input:)
        @map = input
        @row_size = @map.size
        @col_size = @map.first.size
        @antennae = {}
        find_antennae
        @antinodes = []
      end

      def single_antinodes
        @antennae.each do |type, points|
          points.combination(2)
                .each do |pair|
            p1, p2 = Point.from(pair) # p1.row < p2.row

            row_dist = p2.row - p1.row
            col_dist = p2.col - p1.col

            m = col_dist == 0 ? 0 : (row_dist * 1.0 / col_dist)

            [Point.from_ps(p1, p1.row - row_dist, m),
             Point.from_ps(p2, p2.row + row_dist, m)].each do |p|
              r = p.row.to_i
              c = p.col
              if on_map(r, c)
                @antinodes << [r, c]
              end
            end
          end
        end

        @antinodes.uniq!
      end

      def full_antinodes
        @antennae.each do |type, points|
          points.combination(2)
                .each do |pair|
            p1, p2 = Point.from(pair) # p1.row < p2.row

            row_dist = p2.row - p1.row
            col_dist = p2.col - p1.col

            slope = col_dist == 0 ? 0 : (row_dist * 1.0 / col_dist)

            find_antinodes_from(p1, row_dist, slope)
            find_antinodes_from(p2, -row_dist, slope)
          end
        end
        @antinodes.uniq!
      end

      private

      def find_antinodes_from(point, row_dist, m)
        while on_map(point.row, point.col) do
          @antinodes << [point.row, point.col]
          point = Point.from_ps(point, point.row - row_dist, m)
        end
      end

      def find_antennae
        @map.each_with_index do |row, y|
          row.each_with_index do |char, x|
            next if char == "."
            @antennae[char] = [] unless @antennae.key?(char)
            @antennae[char] << [y, x]
          end
        end
      end

      def on_map(row, col)
        row >= 0 && row < @row_size && col >= 0 && col < @col_size
      end
    end

    class Point
      attr_reader :row, :col

      def self.from_ps(point, new_row, slope)
        new_col = (point.col + (new_row - point.row) / slope).to_i
        Point.new(row: new_row, col: new_col)
      end

      def self.from(pair)
        p1 = Point.new(row: pair.first.first, col: pair.first.last)
        p2 = Point.new(row: pair[1].first, col: pair[1].last)
        [p1, p2]
      end

      def initialize(row:, col:)
        @row = row
        @col = col
      end
    end
  end
end
