# frozen_string_literal: true

module Aoc2024
  module Day05
    class Ruleset
      attr_reader :rules

      def self.from(filename)
        new(rules: File.read(filename)
                       .split("\n")
                       .map { |pair| pair.split("|").map(&:to_i) })
      end

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
      def self.factory_from(filename)
        File.read(filename)
          .split("\n")
          .map { |pages| pages.split(",").map(&:to_i) }
          .map { |pages| Update.new(pages: pages) }
      end

      def initialize(pages:)
        @pages = Array(pages)
      end

      def middle
        @pages[@pages.size / 2]
      end

      def make_valid_with!(ruleset)
        @pages.each_with_index do |page, i|
          ruleset.rules.each do |rule|
            next if page != rule.first

            target = @pages.index(rule.last)
            next unless target && i > target

            # swap
            @pages[target], @pages[i] = @pages[i], @pages[target]
          end
        end

        if ruleset.valid_with? pages
          self
        else
          make_valid_with!(ruleset)
        end
      end
    end

    class Puzzle
      def self.from(rules:, updates:)
        new(ruleset: Ruleset.from(rules),
          updates: Update.factory_from(updates))
      end

      def initialize(ruleset:, updates:)
        @ruleset = ruleset
        @updates = updates
      end

      def valid_updates_middle_sums
        @updates.select { |u| @ruleset.valid_with? u.pages }
          .map { |u| u.middle }
          .sum
      end

      def fixed_updates_middle_sums
        @updates.reject { |u| @ruleset.valid_with? u.pages }
          .map { |u| u.make_valid_with! @ruleset }
          .map { |u| u.middle }
          .sum
      end
    end
  end
end
