class CsvModel
  DATA_PATH = File.expand_path('../../data', __FILE__)
  DATA_EXT = '.csv'.freeze
  DATA_READ_OPT = { headers: true, header_converters: :symbol }.freeze
  class << self
      protected


    def data_file

    end
  end
end