module Apfel
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
