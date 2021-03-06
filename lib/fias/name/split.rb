module Fias
  module Name
    module Split
      class << self
        def split(name)
          words = sanitize(name).scan(Fias.word)
          words = cleanup_brackets(words)
          words = split_all_initials(words)
          words = split_all_dotwords(words)

          words
            .reject(&:blank?)
            .flatten
            .uniq
        end

        private

        def sanitize(name)
          Unicode.downcase(name).gsub('ё', 'е').gsub(QUOTAS, '')
        end

        def cleanup_brackets(words)
          words.map { |word, _| word.gsub(BRACKETS, '') }
        end

        def split_all_initials(words)
          words
            .map { |word, _| split_initials(word) || word }
            .compact
            .flatten
        end

        def split_initials(word)
          m_matches = word.match(Fias::INITIALS)
          return m_matches.values_at(1, 3) if m_matches

          s_matches = word.match(Fias::SINGLE_INITIAL)
          return s_matches.values_at(2, 3) if s_matches
        end

        def split_all_dotwords(words)
          words
            .map { |word, _| split_dotwords(word) || word }
            .compact
        end

        def split_dotwords(word)
          return unless word =~ DOTWORD
          dotwords = word.gsub(DOTWORD, '\1 ')
          dotwords.split(' ').uniq.delete_if(&:blank?)
        end
      end

      DOTWORD           = /(#{LETTERS}{2,}\.)/ui
      BRACKETS          = /(\(|\))/
      QUOTAS            = /[\"\']/
    end
  end
end
