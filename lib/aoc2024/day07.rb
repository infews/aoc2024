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
        # Each problem is is Hash, (target vale) => [array of values to operate on]
        @problems = input
      end

      def run_all_operations_with(ops)
        @problems.map do |problem|
          target, values = problem.first
          # Get all permutations of the operations for the number of slots (values.size - 1)
          ops.repeated_permutation(values.size - 1)
             .map do |ops_set|
            first = values.first
            rest = values[1..]

            # zip together operations and values: [[op, val], [op, val]...]
            ops_set.zip(rest)
                   .inject(first) do |acc, pair| # reduce the operations per the rules
              op, val = pair
              if op == "||"
                acc = "#{acc}#{val}".to_i
              else
                acc.send(op.to_sym, val)
              end
            end
          end # has all the results for this problem
          # Do any of them match the target value?
             .any? { |calc| calc == target } ? target : 0
        end.sum
      end

      def solve_part_one
        ops = ["*", "+"]
        run_all_operations_with(ops)
      end

      def solve_part_two
        ops = ["*", "+", "||"]
        run_all_operations_with(ops)
      end
    end
  end
end