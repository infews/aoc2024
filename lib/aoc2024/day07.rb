# frozen_string_literal: true

module Aoc2024
  module Day07
    class Puzzle

      def self.from(filename)
        new(input: File.read(filename, chomp: true)
                       .split("\n")
                       .map { |line| line.split(" ").map(&:to_i) }
                       .map { |a| { a.first => a[1..] } }
        )
      end

      def initialize(input:)
        @problems = input
      end

      def all_calculations_for(values, ops, &block)
        ops.repeated_permutation(values.size - 1)
           .map { |ops_set| yield ops_set, values.first, values[1..] }
      end

      def solve_part_one
        @problems.map do |problem|
          target, values = problem.first
          all_calculations_for(values, ["*", "+"]) do |set, first, rest|
            set.zip(rest)
               .inject(first) do |acc, pair|
              op, val = pair
              acc.send(op.to_sym, val)
            end
          end.any? { |calc| calc == target } ? target : 0
        end.sum
      end

      def solve_part_two
        vals = @problems.map do |problem|
          target, values = problem.first
          all_calculations_for(values,["*", "+", "||"]) do |set, first, rest|
            set.zip(rest)
               .inject(first) do |acc, pair|
              op, val = pair
              if op == "||"
                acc = "#{acc}#{val}".to_i
              else
                acc.send(op.to_sym, val)
              end
            end
          end.any? { |calc| calc == target } ? target : 0
        end
        vals.sum
      end
    end
  end
end
