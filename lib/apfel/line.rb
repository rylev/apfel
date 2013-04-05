module Apfel
  class Line
    attr_reader :content
    attr_accessor :in_comment

    def initialize(line)
      @content = line
      @in_comment = false
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
        unescape_value cleaned_content.partition(/"\s*=\s*"/)[2].gsub!(/(^"|"$)/, "")
      end
    end

    def is_comment?
     whole_comment? || open_comment? || close_comment? || in_comment
    end

    private

    # http://developer.apple.com/library/mac/#documentation/cocoa/conceptual/LoadingResources/Strings/Strings.html
    def unescape_value(string)
      state = :normal
      out = ''
      string.each_char do |c|
        case state
        when :normal
          if c == '\\'
            state = :escape
          else
            out += c
          end
        when :escape
          state = :normal
          case c
          when '\\'
            out += '\\'
          when '"'
            out += '"'
          when 'r'
            out += "\r"
          when 'n'
            out += "\n"
          when 't'
            out += "\t"
          else
            out += '\\' + c # Do nothing, however in the future handling unicode escapes could be good
          end
        end
      end
      out
    end
  end
end
