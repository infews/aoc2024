# frozen_string_literal: true

module Aoc2024
  module Day05
    # The first rule, 47|53, means that if an update includes both page number 47 and page number 53,
    # then page number 47 must be printed at some point before page number 53.
    class Ruleset
      def initialize(rules:)
        @rules = Array(rules)
      end

      def valid_with?(u = [])
        update = Array(u)
        return true if update.empty?

        @rules.map do |rule|
          if update.include?(rule.first) && update.include?(rule.last)
            update.index(rule.first) < update.index(rule.last)
          else
            true
          end
        end.all?
      end
    end

    class Update
      attr_reader :pages

      def initialize(pages:)
        @pages = Array(pages)
      end

      def middle
        @pages[@pages.size / 2]
      end
    end

    class Puzzle
      def self.from(rules:, updates:)
        input = File.read(rules)
          .split("\n")
          .map { |pair| pair.split("|").map(&:to_i) }
        r = Ruleset.new(rules: input)

        u = File.read(updates)
          .split("\n")
          .map { |pages| pages.split(",").map(&:to_i) }
          .map { |pages| Update.new(pages: pages) }
        new(ruleset: r, updates: u)
      end

      def initialize(ruleset:, updates:)
        @ruleset = ruleset
        @updates = updates
      end

      def solution
        @updates.select { |u| @ruleset.valid_with? u.pages }
          .map { |u| u.middle }
          .sum
      end
    end
  end
end
