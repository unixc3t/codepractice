require_relative './conf/init'

`rm -rf #{Country::DATA_FOLDER}` if Dir.exist?(Country::DATA_FOLDER)

Dir.mkdir(Country::DATA_FOLDER)

VK.countries.each do |country_data|
  country = Country.new(country_data['cid'], country_data['title'])
  country.save

  VK.regions(country.cid).each do |region_data|
    region = Region.new(region_data['cid'],
                        region_data['title'],
                        country.folder_name)


    region.save

    VK.cities(country.cid, region.region_id).each do |city_data|
      city = City.new(city_data['cid'], city_data['title'], region)
      city.save
    end
  end
end




