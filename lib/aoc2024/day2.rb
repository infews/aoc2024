# frozen_string_literal: true

module Aoc2024
  module Day2
    def self.parse(filename)
      File.readlines(filename, chomp: true)
        .map { |line| line.split(/\s+/) }
        .map { |a| a.map(&:to_i) }
    end

    class Puzzle1
      def initialize(lines:)
        @lines = lines
      end

      def solution
        @lines.filter_map do |line|
          if line != line.sort && line != line.sort.reverse
            false
          else
            line[0..-2].each_with_index
              .map { |level, i| (level - line[i + 1]).abs }
              .all? { |n| [1, 2, 3].include?(n) }
          end
        end.size
      end

      def self.from(filename)
        new(lines: Day2.parse(filename))
      end
    end
  end
end
