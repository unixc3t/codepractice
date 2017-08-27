class CsvModel
  DATA_PATH = File.expand_path('../../../data', __FILE__)
  DATA_EXT = '.csv'.freeze
  DATA_READ_OPT = { headers: true, header_converters: :symbol }.freeze

  def data_file
    self.class.data_file
  end

  class << self

    def data_file
      DATA_PATH + '/' + to_s.underscore + DATA_EXT
    end

    protected

    def load!
      CSV.read(data_file, DATA_READ_OPT)
    end
  end
end
