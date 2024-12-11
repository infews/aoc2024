module Aoc2024
  module Day09
    class Disk
      attr_reader :first_free_index,
                  :last_file_index,
                  :total_free_space

      def self.from(filename)
        new(input: File.read(filename)
                       .chars
                       .map(&:to_i))
      end

      def initialize(input:)
        @first_free_index = nil
        @total_free_space = 0
        @last_file_index = nil
        @map = build_map(input)
      end

      def id_map
        @map.keys.sort.map { |key| @map[key][:id] * @map[key][:length] }
      end

      def compact!
        # THIS IS NOT RIGHT FOR THE BREAK
        while @first_free_index != (@last_file_index + @map[@last_file_index][:length])
          first_free = @map[@first_free_index]
          last_file = @map[@last_file_index]

          if first_free[:length] < last_file[:length]
            size_moved = first_free[:length]
            last_file[:length] -= size_moved
            first_free[:id] = last_file[:id]

            @first_free_index = @first_free_index + size_moved + @map[@first_free_index + size_moved][:length]

            past_remaining_last_file = @map[@last_file_index][:length]
            @map[@last_file_index + past_remaining_last_file] = { id: ".", length: size_moved }
          else
            # first_free[:length] >= last_file[:length]
            size_moved = last_file[:length]
            @map[@first_free_index] = last_file

            if first_free[:length] > last_file[:length]
              first_free[:length] -= size_moved
              @first_free_index += size_moved
              @map[@first_free_index] = first_free
            else
              # length == free length
              @first_free_index = @first_free_index + size_moved + @map[@first_free_index + size_moved][:length]
            end

            @map[@last_file_index] = { id: ".", length: size_moved }
            @last_file_index = find_last_file_index
          end
        end
      end

      def filesystem_checksum
        id_map.join
              .chars
              .map.with_index do |id, index|
          id.to_i * index
        end.sum
      end

      private

      def find_last_file_index
        @map.keys.sort.reverse.find { |index, _block| @map[index][:id] != "." }
      end

      def build_map(input)
        file_number = -1
        index = 0
        input.each_with_index.inject({}) do |map, (num, i)|
          map[index] = if i.even?
                         file_number += 1
                         @last_file_index = index
                         { id: file_number.to_s, length: num }
                       else
                         @first_free_index ||= index
                         @total_free_space += num
                         { id: ".", length: num }
                       end
          index += num
          map
        end
      end
    end
  end
end
