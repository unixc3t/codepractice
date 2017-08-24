class Country
  DATA_FOLDER = './world/data/'

  attr_accessor :cid, :title

  def initialize(cid, title)
    @cid = cid
    @title = title
  end

  def save
    Dir.mkdir(full_folder_path) unless Dir.exist?(full_folder_path)
  end


  def regions
    Region.load!(self)
  end


  class << self
    def load!(fold = DATA_FOLDER)
      dir = Dir.new(fold)
      res = []
      while dir_name = dir.read
        unless %w(. ..).include?(dir_name)
          dir_data = dir_name.split('_')
          res << new(dir_data.first, dir_data.last)
        end
      end
      res
    end
  end


  def full_folder_path
    DATA_FOLDER + folder_name
  end

  def folder_name
    "#{@cid}_#{@title}"
  end

  def to_json(*arg)
    puts arg
    as_json.to_json
  end

  def as_json
    {
        cid: @cid,
        title: @title
    }
  end
end