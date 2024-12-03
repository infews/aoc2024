# frozen_string_literal: true

module Aoc2024
  module Day3
    def self.parse(filename)
      File.readlines(filename, chomp: true)
        .map { |line| line.scan(/mul(\(\d+,\d+\))?/) }
        .flatten
        .map do |mult|
        /(?<a>\d+),(?<b>\d+)/ =~ mult
        [a.to_i, b.to_i]
      end
    end

    class Puzzle
      def self.from(filename)
        new(pairs: Day3.parse(filename))
      end

      def initialize(pairs:)
        @pairs = pairs
      end

      def solution
        @pairs.map { |a| a.first * a.last }.sum
      end
    end
  end
end
