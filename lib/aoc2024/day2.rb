# frozen_string_literal: true

module Aoc2024
  module Day2
    def self.parse(filename)
      File.readlines(filename, chomp: true)
        .map { |line| line.split(/\s+/) }
        .map { |a| a.map(&:to_i) }
    end

    class Puzzle
      def initialize(lines:)
        @lines = lines
      end

      def solution
        @lines.filter_map { |line| safe?(line) }.size
      end

      def solution_with_dampers
        @lines.filter_map { |line| safe?(line) || safe_with_dampener?(line) }.size
      end

      def self.from(filename)
        new(lines: Day2.parse(filename))
      end

      private

      def safe?(line)
        levels_all_ascend_or_descend(line) && all_levels_within_tolerances?(line)
      end

      def all_levels_within_tolerances?(line)
        line[0..-2].each_with_index
          .map { |level, i| (level - line[i + 1]).abs }
          .all? { |n| [1, 2, 3].include?(n) }
      end

      def levels_all_ascend_or_descend(line)
        line == line.sort || line == line.sort.reverse
      end

      def safe_with_dampener?(line)
        remove = 0
        while remove <= line.size - 1
          without_level = line.dup.tap { |l| l.delete_at(remove) }
          if safe?(without_level)
            return true
          end
          remove += 1
        end
        false
      end
    end
  end
end
