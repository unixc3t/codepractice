require 'spec_helper'
require './world/vk'
require './world/country'

describe 'VK' do

  it 'get countries' do
    puts VK.countries
  end
  it 'get regions' do
    puts VK.regions(85)
  end
  it 'get cities' do
    puts VK.cities(85, 4470)
  end

  it 'create data fold' do
    VK.countries.each do |country_data|
    end
  end

end