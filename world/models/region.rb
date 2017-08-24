require_relative './city'

class Region
  DATA_FOLDER = './data/'

  attr_accessor :region_id, :title, :country_fold

  def initialize(region_id, title, country_fold)
    @region_id = region_id
    @country_fold = country_fold
    @title = title
  end

  def save
    File.open(full_file_path, 'w') do |file|
      file.write("#{@title}\n")
    end
  end

  def cities
    City.load!(self)
  end

  class << self
    def load!(country)
      dir_country = Dir.new(country.full_folder_path)
      region_files = dir_country.map {|file_name| file_name}
                         .select do |file_name|
        !%w(. ..).include?(file_name)
      end

      region_files.map do |file_name|
        new(file_name.gsub('.txt', ''),
            File.readlines("#{country.full_folder_path}/#{file_name}")
                .first.strip,
            country.full_folder_path)

      end
    end
  end


  def full_file_path
    DATA_FOLDER + @country_fold + '/'+file_name
  end

  private

  def file_name
    "#{@region_id}.txt"
  end
end