require 'pry'
require_relative 'transformer'
require_relative 'database'

class FrancaRecord
  extend Transformer

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
    self.id = Database.instance.client.last_id
  end

  def update(data)
    formatted_data = data.map{ |key, value| "#{key}='#{value}'" }.join(',')
    Database.instance.client.query("Update #{self.class.table} SET #{formatted_data} WHERE id=#{self.id};")
    data.each { |key, value| self.send("#{key.to_s}=", value) }
  end

  def delete
    Database.instance.client.query("DELETE FROM #{self.class.table} WHERE id=#{self.id};")
    # is it possible to delte a class_instance?
    #binding.pry
    #self
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
