class GuestBook < CsvModel

  AVAILABLE_ATTRS = %w(email ip nick text)

  attr_accessor :email, :ip, :nick, :text, :created_at

  def initialize(options={})
    options.each do |meth, val|
      send("#{meth}=".to_sym, val)
    end
  end

  class << self
    def all
      load!.map do |row|
        new(row.to_h)
      end
    end
  end

  def created_human_at
    time_at = Time.at(created_at.to_i)
    "#{time_at.year}-#{time_at.month}-#{time_at.day}"
  end

  def save
    CSV.open(data_file, 'a+') do |file|

      self.created_at ||= Time.now.to_i.to_s


      data = CSV.read(data_file).first.map do |header|
        send(header)
      end

      file << data
    end
  end

  private

  def csv_data_format

  end

end

