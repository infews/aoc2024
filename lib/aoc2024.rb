# frozen_string_literal: true

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), "aoc2024")

Dir.glob(File.join(File.dirname(__FILE__), "aoc2024/*.rb"))
  .each { |day| require day }

module Aoc2024
  class Error < StandardError; end
  # Your code goes here...
end
