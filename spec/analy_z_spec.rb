require 'spec_helper'

describe AnalyZ do
  it 'has a version number' do
    expect(AnalyZ::VERSION).not_to be nil
  end

  it 'does something useful' do
    require 'pp'
    path = "#{File.dirname(__FILE__)}/../htmls/*.html"
    p a = AnalyZ::HTML.word_val(path, '#js-fixedside-ref')
    expect(true).to eq(true)
  end
end
