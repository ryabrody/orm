require 'singleton'
require 'yaml'
require 'mysql2'

class Database
  include Singleton

  attr_reader :client, :tables

  def initialize
    @client = client
    @tables = tables
  end

  def client
    begin
      Mysql2::Client.new(YAML.load_file('database.yml'))
    rescue Mysql2::Error => e
      puts e
      puts 'Check if mysql server is running. Start mysql with: $ mysql.server start'
    end
  end

  def tables
    result = client.query("SHOW TABLES;")
    useful_tables(result)
  end

  private

  def useful_tables(mysql2_result)
    tables = mysql2_result.map { |table| table["Tables_in_#{client.query_options[:database]}"] }
    reserved_tables = %w(ar_internal_metadata schema_migrations)
    tables - reserved_tables
  end
end
