class GuestBook < CsvModel


  attr_accessor :email, :ip, :nick, :text, :created_at

  def initialize(**options)
    options.each do |meth, val|
      send("#{meth}=".to_sym, val)
    end
  end

  class << self
    def all
      CSV.read(DATA_FILE, DATA_READ_OPT).map do |row|
        new(row.to_h)
      end
    end
  end
end

