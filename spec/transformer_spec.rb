require 'spec_helper'
require_relative '../transformer'

describe '#tableize' do
  it 'returns tableized string of class "DummyClass"' do
    class DummyClass
      include Transformer
    end

    dummy_class = DummyClass.new
    class_name = dummy_class.class.name
    expect(dummy_class.tableize(class_name)).to eq('dummy_classes')
  end

  it 'returns tableized string of class "Note"' do
    class Flote
      include Transformer
    end

    dummy_class = Flote.new
    class_name = dummy_class.class.name
    expect(dummy_class.tableize(class_name)).to eq('flotes')
  end
end
