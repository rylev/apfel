module Apfel
  class KVPair
    attr_reader :line, :raw_comment

    def initialize(line, comment)
     @line = line
     @raw_comment = comment
    end

    def key
     line.key.strip unless line.key.nil?
    end

    def value
     line.value.strip unless line.key.nil?
    end

    def comment
      if raw_comment.nil?
        @raw_comment = ""
      else
        raw_comment.gsub!(/(\/\*)|(\*\/)/,"")
        raw_comment.gsub!("\n", " ")
        raw_comment.gsub!(/\s+/, " ")
        raw_comment.strip
      end
    end
  end
end
