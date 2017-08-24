require 'spec_helper'
require './test'

require 'pathname'
describe 'Test' do
  it 'all the fine' do
    expect(true).to eq true
  end

  it 'work' do
    expect(hello(1)).to eq 2
  end
end



