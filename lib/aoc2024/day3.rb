# frozen_string_literal: true

module Aoc2024
  module Day3
    class Puzzle
      def self.from_raw_parsing(filename)
        new(segments: File.read(filename)
                          .split("\n"))
      end

      def self.from_parsing_with_toggle(filename)
        new(segments: File.read(filename)
                          .split("do")
                          .reject { |segment| segment =~ /^n't/ })
      end

      def initialize(segments:)
        @segments = segments
      end

      def solution
        @segments.map { |segment| segment.scan(/mul(\(\d+,\d+\))?/) }
          .flatten
          .map { |mult| multiply_pair_from(mult) }
          .sum
      end

      def multiply_pair_from(mult)
        /(?<a>\d+),(?<b>\d+)/ =~ mult
        a.to_i * b.to_i
      end
    end
  end
end
