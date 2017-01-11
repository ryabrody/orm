require 'pry'
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

  def create
    values = self.class.fields.map { |field| self.send(field) }
    data = data(self.class.fields, values)


    Database.instance.client.query("INSERT INTO #{self.class.table} (#{data.keys.join(', ')}) VALUES (#{data.values.join(', ')});")
    #client.last_id
  end

  def update(data)
  end

  def self.fields
    self.all.fields
  end

  def self.all
    Database.instance.client.query("SELECT * FROM #{self.table}")
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

# refactore self.class stuff
# check data
# mysql -h localhost -u root -p rails_app_development
# desc notes;
# SELECT * FROM notes;
