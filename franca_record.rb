require 'pry'
require 'yaml'
require 'mysql2'
require_relative 'transformer'

class FrancaRecord
  extend Transformer

  #attr_reader :table, :client, :fields

  def initialize(attributes = {})
    self.class.fields.each do |field|
      self.class.send(:attr_accessor, field)
      instance_variable_set "@#{field}", attributes[field.to_sym]
    end
  end

  def self.fields
    self.all.fields
  end

  def create
    values = self.class.fields.map { |field| self.send(field) }
    data = data(self.class.fields, values)
    binding.pry

    self.class.client.query("INSERT INTO #{self.class.table} (#{data.keys.join(', ')}) VALUES (#{data.values.join(', ')});")
  end


  def self.all
    self.client.query("SELECT * FROM #{self.table}")
  end

  def self.client
    begin
      Mysql2::Client.new(YAML.load_file('database.yml'))
    rescue Mysql2::Error => e
      puts e
      puts 'Check if mysql server is running. Start mysql with: $ mysql.server start'
    end
  end

  def self.table
    tableize(self.name)
  end


  private



  def data(fields, values)
    data = {}
    fields.zip(values).map do |field, value|
      unless value.nil?
        data[field] = "'#{value}'"
      end
    end
    data
  end
end

# check data
# mysql -h localhost -u root -p rails_app_development
# desc notes;
# SELECT * FROM notes;
