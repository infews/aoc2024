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
        @free_block_indexes = []

        @disk = build_map(input)
      end

      def id_map
        @disk.keys.sort.map { |key| @disk[key][:id] * @disk[key][:length] }
      end

      def last_file_block_index
        @file_indexes.last
      end

      def first_free_block_index
        @free_block_indexes.first
      end

      def compact_free_space!
        file_index = @file_indexes.pop
        free_index = @free_block_indexes.shift

        while free_index <= file_index
          free = @disk[free_index]
          file = @disk[file_index]

          if free[:length] == file[:length]
            @disk[free_index] = file
            @disk[file_index] = { id: ".", length: file[:length] }

            free_index = @free_block_indexes.shift
            file_index = @file_indexes.pop
          elsif free[:length] > file[:length]
            @disk[free_index] = file
            @disk[file_index] = { id: ".", length: file[:length] }

            free[:length] -= file[:length]
            free_index += file[:length]
            @disk[free_index] = free
            file_index = @file_indexes.pop
          else
            # free[:length] < file[:length]
            size_moved = free[:length]
            @disk[free_index][:id] = file[:id]
            @disk[file_index][:length] -= size_moved
            next_index_after_shorter_file = file_index + @disk[file_index][:length]
            @disk[next_index_after_shorter_file] = { id: ".", length: size_moved }

            free_index = @free_block_indexes.shift
          end
        end
      end

      def defrag_whole_files!
        @file_indexes.reverse.each do |file_index|
          file = @disk[file_index]
          size_to_move = file[:length]

          @free_block_indexes.each_with_index do |free_index, i|
            free = @disk[free_index]

            next if size_to_move > free[:length]

            if size_to_move == free[:length]
              @disk[free_index] = file
              @disk[file_index] = free
              @free_block_indexes.delete(free_index)
              break
            else # size_to_move < free[:length]
              @disk[free_index] = file
              @disk[file_index] = { id: ".", length: size_to_move }

              @disk[free_index + size_to_move] = { id: ".", length: free[:length] - size_to_move }
              @free_block_indexes[i] = free_index + size_to_move
              break
            end
          end
        end
      end

      def filesystem_checksum
        block_index = -1
        @disk.keys
             .sort
             .sum do |disk_index|
          (1..@disk[disk_index][:length]).sum do |_l|
            block_index += 1
            @disk[disk_index][:id].to_i * block_index
          end
        end
      end

      private

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
                           @free_block_indexes << index
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
