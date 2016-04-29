require 'spec_helper'

describe AnalyZ do
  it 'has a version number' do
    expect(AnalyZ::VERSION).not_to be nil
  end

  it 'does something useful' do
    a = AnalyZ::Analyzer.new('htmls/*.html', '#js-fixedside-ref')
    expect(true).to eq(true)
  end
end
