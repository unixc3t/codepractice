class MysqlModel
  CONFIG = YAML.safe_load(
    File.read(File.expand_path('../../conf/database.yml', File.dirname(__FILE__)))
  ).freeze
  class << self

    def attribute_accessible(*args)
      attr_accessor *args
      @available_attrs = args
    end

    def available_attrs
      @available_attrs
    end

    def client
      @@client ||= Mysql2::Client.new(CONFIG)
    end

    def all
      client.query("select * from #{table_name}").map do |attributes|
        new(attributes)
      end
    end

    def find(row_id)
      select_sql = "select * from  #{table_name} where id = #{row_id}"
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
    client.query(insert_sql(available_attrs, values))
  end


  def destroy
    client.query(delete_sql)
  end


  private

  def insert_sql(fields, values)
    "insert into #{table_name} (#{fields.join(', ')}) values (#{values.join(', ')})"
  end

  def delete_sql
    "delete from #{table_name} where id = #{id}"
  end


  def define_from_class
    [:available_attrs, :client, :table_name].each do |method_name|
      define_singleton_method(method_name) do
        self.class.send(method_name)
      end
    end
  end

end