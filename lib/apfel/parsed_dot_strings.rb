module Apfel
  require 'json'
  class ParsedDotStrings
    attr_accessor :kv_pairs

    def initialize
      @kv_pairs = []
    end

    def key_values
      kv_pairs.map do |pair|
        {pair.key => pair.value}
      end
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

    def comments(args={})
      with_keys = args[:with_keys].nil? ? true : args[:with_keys]
      cleaned_pairs = kv_pairs.map do |pair|
        pair
      end
      with_keys ? build_comment_hash(cleaned_pairs) : cleaned_pairs.map(&:comment)
    end

    def to_hash(args={})
      no_comments = args[:no_comments].nil? ? false : args[:no_comments]

      build_hash { |hash, pair|
      hash_value = no_comments ? pair.value : { pair.value => pair.comment }
        hash[pair.key] = hash_value
      }
    end

    def to_json(args={})
      self.to_hash(no_comments: args[:no_comments]).to_json
    end

    private

      def build_comment_hash(kv_pairs)
        build_hash { |hash, pair|
          hash[pair.key] = pair.comment
        }
      end

      def build_hash(&block)
        hash = {}
        kv_pairs.each do |pair|
          yield hash, pair
        end
        hash
      end
  end
end
