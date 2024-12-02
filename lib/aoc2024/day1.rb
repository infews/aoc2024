# frozen_string_literal: true

module Aoc2024
  module Day1
    class Puzzle1
      def initialize(list_1:, list_2:)
        @list_1 = list_1.sort
        @list_2 = list_2.sort
      end

      def solution
        @list_1.zip(@list_2)
          .map { |pair| pair.first - pair.last }
          .map { |n| n.abs }
          .sum
      end

      def self.from(filename)
        lol = File.readlines(filename, chomp: true).map { |line| line.split(/\s+/) }
          .map { |a| [a.first.to_i, a.last.to_i] }
        list_1 = lol.map { |a| a.first.to_i }
        list_2 = lol.map { |a| a.last.to_i }

        new(list_1: list_1, list_2: list_2)
      end
    end
  end
end
