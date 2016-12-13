require 'pry'
require 'yaml'
require 'mysql2'
require_relative 'transformer'

class FrancaRecord
  include Transformer

  def initialize(attributes = {})
    @table = tableize(self.class.name)
    result.fields.each do |field|
      self.class.send(:attr_accessor, field)
      instance_variable_set "@#{field}", attributes[field.to_sym]
    end
  end

  def self.create(object)
  end

  private

  def client
    begin
      Mysql2::Client.new(YAML.load_file('database.yml'))
    rescue Mysql2::Error => e
      puts e
      puts 'Check if mysql server is running. Start mysql with: $ mysql.server start'
    end
  end

  def result
    client.query("SELECT * FROM #{@table}")
  end
end
