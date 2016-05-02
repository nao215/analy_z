module AnalyZ

  class << self
    def HTML html_path, selector = 'body', type_ary = ['名詞']
      AnalyZ::HTML
    end

  end

  module HTML

    def self.word_val html_path, selector = 'body', type_ary = ['名詞']
      WordVal.new(html_path, selector, type_ary)
    end

  end

end

