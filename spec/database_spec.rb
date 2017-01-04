require 'spec_helper'

describe Database do

  let(:database) { Database.instance }

  it 'initializes a database' do
    expect(database).to be_an_instance_of(Database)
  end

  it 'has a getter called client' do
    expect(database.client).to be_an_instance_of(Mysql2::Client)
  end

  it 'has a getter called tables' do
    expect(database.tables).to eq(%w(notes))
  end
end
