module Apfel
  class Line
    attr_reader :content

    def initialize(line)
      @content = line
      raise "Line does not end in ;" unless valid?
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

    def valid?
      if key_value_pair?
        puts content
        !!(/;[\s]*$/.match(content))
      else
        true
      end
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
end
