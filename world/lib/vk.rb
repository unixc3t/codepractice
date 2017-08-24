require 'json'
require 'net/http'
require 'uri'

module VK
  HOST = 'https://api.vk.com/method/'.freeze

  METHOD = {
    countries: 'database.getCountries',
    regions: 'database.getRegions',
    cities: 'database.getCities'
  }.freeze

  class<< self
    def countries
      request(countries_url)
    end

    def regions(country_id)
      request(regions_url(country_id))
    end

    def cities(country_id, region_id)
      request(cities_url(country_id, region_id))
    end


    private

    def countries_url
      HOST + METHOD[:countries] + '?need_all=1&count=10'
    end

    def regions_url(country_id)
      HOST + METHOD[:cities] + "?count=10&country_id=#{country_id}"
    end

    def cities_url(country_id, region_id)
      query = "?count=10&country_id=#{country_id}&region_id=#{region_id}"
      HOST + METHOD[:cities] + query
    end

    def request(url)
      JSON.parse(Net::HTTP.get(URI(url)))['response']
    end


  end
end