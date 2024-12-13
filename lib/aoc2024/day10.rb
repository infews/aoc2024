module Aoc2024
  module Day10
    class LavaMap
      NEXT_DIR = { up: :right, right: :down, down: :left, left: :up }
      NEXT_ROW = { up: -1, right: 0, down: 1, left: 0 }
      NEXT_COL = { up: 0, right: 1, down: 0, left: -1 }

      attr_reader :trailheads

      def self.from(filename)
        new(input: File.readlines(filename, chomp: true)
                       .map { |line| line.chars })
      end

      def initialize(input:)
        @map = build_map(input)
        @row_size = @map.size
        @col_size = @map.first.size
        @trailheads = []
        find_trailheads
      end

      def score
        0
        # @trailheads.sum do |t|
        #
        # end
      end

      private

      def build_map(input)
        input.map do |line|
          line.map do |pos|
            pos == "." ? pos : pos.to_i
          end
        end
      end

      def find_trailheads
        @map.each_with_index do |line, row|
          line.each_with_index do |pos, col|
            if pos == 0
              @trailheads << [row, col]
            end
          end
        end
      end

      def on_map(pos)
        r, c = pos
        r >= 0 && r < @row_size && c >= 0 && c <= @col_size
      end

      def next_position(row, col, direction)
        [row + NEXT_ROW[direction],
         col + NEXT_COL[direction]]
      end
    end
  end
end
