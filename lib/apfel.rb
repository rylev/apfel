#!/usr/bin/env ruby
# encoding: UTF-8
module Apfel

  module DotStrings
    def self.parse(file)
      file = read_file(file)
      DotStringsParser.new(file).parse_file
    end

    def self.read_file(file)
     Reader.read(file)
    end
  end

  class Reader
    # Reads in a file and returns an array consisting of each line of input
    def self.read(file)
      File.open(file, "r") do |f|
      content_array=[]
      content = f.read
        content.each_line do |line|
          content_array.push(line)
        end
        content_array
      end
    end
  end

  class ParsedDotStrings
    attr_accessor :kv_pairs

    def initialize
      @kv_pairs = []
    end

    def keys
      kv_pairs.map do |pair|
        pair.key
      end
    end

    def values
      kv_pairs.map do |pair|
        pair.value
      end
    end

    def comments
      kv_pairs.map do |pair|
       pair.comment.gsub("\n"," ")
      end
    end

    def to_hash
      hash = {}
      kv_pairs.each do |pair|
        hash[pair.key] = { pair.value => pair.comment }
      end
      hash
    end
  end

  class DotStringsParser
    KEY = "KEY"
    COMMENT = "COMMENT"

    def initialize(read_file, parsed_file = ParsedDotStrings.new)
      @read_file = read_file
      @parsed_file = parsed_file
    end

    def parse_file
      state = KEY
      current_comment = nil
      comments_for_keys = {}
      @read_file.each do |content_line|
        current_line = Line.new(content_line)
        next if current_line.empty_line?

        #State machine to parse the comments
        case state
        when KEY
          if current_line.whole_comment?
            unless current_line.whole_comment.strip == 'No comment provided by engineer.'
              current_comment = current_line.whole_comment
            end
          elsif current_line.key_value_pair? && current_comment
            comments_for_keys[current_line.key] = current_comment
            current_comment = nil
          elsif current_line.open_comment?
            current_comment = current_line.open_comment + "\n"
            state = COMMENT
          end
        when COMMENT
          if current_line.close_comment?
            current_comment += current_line.close_comment
            state = KEY
          else
            current_comment += current_line.content
          end
        end

        unless current_line.is_comment?
          @parsed_file.kv_pairs << KVPair.new(current_line, comments_for_keys[current_line.key])
        end
      end

      raise "Invalid .string file: Unterminated comment" unless state == KEY
      parsed_file
    end


  end

  class Line
    attr_reader :content

    def initialize(line)
      @content = line
    end

    def empty_line?
      /^\s*$/.match(content) || false
    end

    def whole_comment
      /((^\/\*(.+)\*\/)|(^\/\/(.+)))/.match(content).to_s
    end

    def whole_comment?
      !(whole_comment.empty?)
    end

    def open_comment
      /^\/\*(.+)$/.match(content).to_s
    end

    def open_comment?
      !(open_comment.empty?)
    end

    def close_comment
      /^(.+)\*\/\s*$/.match(content).to_s
    end

    def close_comment?
      !(close_comment.empty?)
    end

    def key_value_pair?
      !!(/^\s*"([^"]+)"\s*=/.match(content))
    end

    def cleaned_content
      content.gsub(/;\s*$/, "")
    end

    def key
      if key_value_pair?
        cleaned_content.partition(/"\s*=\s*"/)[0].gsub!(/(^"|"$)/, "")
      end
    end

    def value
      if key_value_pair?
        cleaned_content.partition(/"\s*=\s*"/)[2].gsub!(/(^"|"$)/, "")
      end
    end

    def is_comment?
     whole_comment? || open_comment? || close_comment?
    end
  end

  class KVPair
    attr_reader :line, :raw_comment

    def initialize(line, comment)
     @line = line
     @raw_comment = comment
    end

    def key
     line.key
    end

    def value
     line.value
    end

    def comment
      if raw_comment.nil?
        @raw_comment = ""
      else
        raw_comment.gsub!(/(\/\*)|(\*\/)/,"")
        raw_comment.strip
      end
    end
  end
end
