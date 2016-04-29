require "analy_z/version"

module AnalyZ

  class Analyzer

    require 'pp'
    require 'natto'
    require 'nokogiri'

    attr_accessor :tf
    attr_accessor :idf
    attr_accessor :tf_idf
    attr_accessor :words
    attr_accessor :texts
    attr_accessor :sentences

    def initialize html, selector = 'body', type_ary = ['名詞']
      @sentences = {}
      Dir.glob("htmls/*.html").each do |f|
        @sentences[f] = parse_html(Nokogiri::HTML.parse(File.read(f), nil, nil).css(selector).to_html)
      end
      analyze_words(@sentences)
    end

    def analyze_words sentences, type_ary = ['名詞']

      @texts, @words, @tf, @idf = {}, {}, {}, {}

      sentences.each{|k, sentence| @texts[k] = sentence.map {|s| s[0]}.join }

      sentences.each do |key, sentence|
        text = sentence.map {|s| s[0] }.join
        @words[key] = parse_by_natto(text, type_ary)
        @tf[key] = calc_tf(@words[key])
        @idf[key] = calc_idf(@texts, @words[key])
      end

      @tf_idf = calc_tf_idf(@tf, @idf)

    end

    def parse_html html
      html.gsub(/\"/, '')
          .split(/<(".*?"|'.*?'|[^'"])*?>|。|！|？|\!|\?/)
          .map{|s| s.gsub(/\"/, '')}
          .delete_if{|el| el =~ /\s|\w|\// || el.length <= 2 }
          .map{|s| [s, 1]}
    end

    def parse_by_natto text, type_ary
      words = []

      Natto::MeCab.new.parse(text).split(/\n/).map do |row|
        row = row.split(/\t|,/)
        words << row[0] if type_ary.include?(row[1]) # row[0] is word, row[1] is a part of speech
      end

      words
    end

    def calc_tf words
      freq_hash = {}

      words.each_with_index do |word, i|
        freq_hash[word] = freq_hash.has_key?(word) ? freq_hash[word] + 1 : 1
      end

      tf_list = freq_hash.sort_by {|k, v| v }.reverse.map do |k, v|
        [k, v / words.length.to_f]
      end

      tf_list    
    end

    def standardization_tf tf_ary_list, ave_word_num
      return tf_ary_list.map do |tf_ary|
        tf_ary.map do |tf|
          [tf[0], tf[1] * (tf_ary.length / ave_word_num.to_f), tf_ary.length / ave_word_num.to_f]
        end
      end
    end

    def calc_idf sentences, words
      words.map do |word|
        cnt = 0
        sentences.each {|k, v| cnt += 1 if v.include?(word) }
        [word, Math.log(sentences.length / cnt.to_f)]
      end
    end

    def calc_tf_idf tf_list_hash, idf_list_hash

      tf_idfs = {}

      tf_list_hash.each do |k, tf|
        tf_idf = []
        idf_list_hash[k].each do |idf|
          tf_idf << [idf[0], idf[1] * tf.assoc(idf[0])[1]]
        end
        tf_idfs[k] = tf_idf.sort{ |a, b| b[1] <=> a[1] }.uniq
      end

      tf_idfs

    end

  end

end
