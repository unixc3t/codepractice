class MysqlModel
  CONFIG = YAML.safe_load(
    File.read(File.expand_path('../../conf/database.yml', File.dirname(__FILE__)))
  ).freeze
  class << self
    def attribute_accessible(*args)
      attr_accessor *args
      @available_attrs = args
    end

    attr_reader :available_attrs

    def client
      @@client ||= Mysql2::Client.new(CONFIG)
    end

    def all
      client.query("select * from #{table_name}").map do |attributes|
        new(attributes)
      end
    end

    def where(options)
      options = options.select { |_, v| v.present? }
      if options.present?
        condition = options.to_a.map { |x| "#{x[0]} = '#{x[1]}'" }.join(' and ')
        client.query("select * from #{table_name} where #{condition} ;").map do |attributes|
          new(attributes)
        end
      else
        all
      end
    end

    def find_by(options)
      options = options.select { |_, v| v.present? }
      return nil unless options.present?
      where(options).first
    end

    def find(row_id)
      select_sql = "select * from  #{table_name} where id = #{row_id};"
      attributes = client.query(select_sql).first
      return nil unless attributes
      new(attributes)
    end

    def table_name
      to_s.underscore.pluralize
    end

    def include_attribute?(attr)
      available_attrs.include? attr.to_sym
    end
  end

  def initialize(attributes = {})
    attributes.each do |attr_name, attr_value|
      send("#{attr_name}=", attr_value)
    end

    define_from_class
  end

  def save
    values = available_attrs.map do |attr_name|
      "'#{send(attr_name)}'"
    end

    if created?
      client.query(update_sql(available_attrs, values))
    else
      client.query(insert_sql(available_attrs, values))
    end
  end

  def update(attributes)
    assigne_attributes(attributes)
    save
  end

  def destroy
    client.query(delete_sql)
  end

  def created?
    id.present?
  end



  private

  def update_sql(fields, values)
    attributes = {}.tap do |x|
      fields.each_with_index do |val, index|
        x[val] = values[index]
      end
    end
    attr_sql = attributes.map { |k, v| "#{k}=#{v}" }.join(',')
    "update #{table_name} set #{attr_sql}  where id = #{id};"
  end

  def assigne_attributes(attributes)
    attributes.each do |attr_name, attr_value|
      send("#{attr_name}=", attr_value)
    end
  end

  def insert_sql(fields, values)
    "insert into #{table_name} (#{fields.join(', ')}) values (#{values.join(', ')});"
  end

  def delete_sql
    "delete from #{table_name} where id = #{id};"
  end

  def define_from_class
    [:available_attrs, :client, :table_name].each do |method_name|
      define_singleton_method(method_name) do
        self.class.send(method_name)
      end
    end
  end
end
