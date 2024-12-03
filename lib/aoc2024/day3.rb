# frozen_string_literal: true

module Aoc2024
  module Day3
    def self.raw_parse(filename)
      File.readlines(filename, chomp: true)
          .map { |line| line.scan(/mul(\(\d+,\d+\))?/) }
          .flatten
          .map do |mult|
        /(?<a>\d+),(?<b>\d+)/ =~ mult
        [a.to_i, b.to_i]
      end
    end

    def self.parse_with_toggle(filename)
      input = File.read(filename, chomp: true)
      input.split("do")
          .flatten
          .select { |segment| !(segment =~ /^n't/) }
          .map { |segment| segment.scan(/mul(\(\d+,\d+\))?/) }
          .flatten
          .map do |mult|
        /(?<a>\d+),(?<b>\d+)/ =~ mult
        [a.to_i, b.to_i]
      end
    end

    class Puzzle
      def self.from_raw_parsing(filename)
        new(pairs: Day3.raw_parse(filename))
      end

      def self.from_parsing_with_toggle(filename)
        new(pairs: Day3.parse_with_toggle(filename))
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
