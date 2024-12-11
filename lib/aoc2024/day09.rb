module Aoc2024
  module Day09
    class Disk
      attr_reader :first_free_index,
                  :total_free_space

      def self.from(filename)
        new(input: File.read(filename)
                       .chars
                       .map(&:to_i))
      end

      def initialize(input:)
        @total_free_space = 0
        @file_indexes = []
        @empty_block_indexes = []

        @disk = build_map(input)
      end

      def id_map
        @disk.keys.sort.map { |key| @disk[key][:id] * @disk[key][:length] }
      end

      def last_file_block_index
        @file_indexes.last
      end

      def first_free_block_index
        @empty_block_indexes.last
      end

      def compact_free_space!
        last_file_index = @file_indexes.pop
        first_free_index = @empty_block_indexes.pop

        while first_free_index <= last_file_index
          first_free = @disk[first_free_index]
          last_file = @disk[last_file_index]

          if first_free[:length] == last_file[:length]
            @disk[first_free_index] = last_file
            @disk[last_file_index] = { id: ".", length: last_file[:length] }

            first_free_index = @empty_block_indexes.pop
            last_file_index = @file_indexes.pop
          elsif first_free[:length] > last_file[:length]
            @disk[first_free_index] = last_file
            @disk[last_file_index] = { id: ".", length: last_file[:length] }

            first_free[:length] -= last_file[:length]
            first_free_index += last_file[:length]
            @disk[first_free_index] = first_free
            last_file_index = @file_indexes.pop
          else
            # first_free[:length] < last_file[:length]
            size_moved = first_free[:length]
            @disk[first_free_index][:id] = last_file[:id]
            @disk[last_file_index][:length] -= size_moved
            next_index_after_shorter_file = last_file_index + @disk[last_file_index][:length]
            @disk[next_index_after_shorter_file] = { id: ".", length: size_moved }

            first_free_index = @empty_block_indexes.pop
          end
        end
      end

      def defrag_whole_files!
        # while @file_indexes.any?
        #   last_file_index = @file_indexes.pop
        #
        #
        #
        #
        # end
      end

      def filesystem_checksum
        block_index = -1
        @disk.keys
             .sort
             .sum do |key|
          (1..@disk[key][:length]).sum do |_l|
            block_index += 1
            @disk[key][:id].to_i * block_index
          end
        end
      end

      private

      def next_free_block
        index = @first_free_index + @disk[@first_free_index][:length]
        while @disk[index][:id] != "."
          index += @disk[index][:length]
        end
        index
      end

      def build_map(input)
        file_number = -1
        index = 0
        input.each_with_index.inject({}) do |map, (size, i)|
          map[index] = if i.even?
                         file_number += 1
                         @file_indexes << index
                         { id: file_number.to_s, length: size }
                       else
                         if size > 0
                           @empty_block_indexes.unshift(index)
                           # @first_free_index ||= index
                           @total_free_space += size
                           { id: ".", length: size }
                         end
                       end
          index += size
          map
        end

      end
    end
  end
end
