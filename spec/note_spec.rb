require 'spec_helper'

describe Note do
  let(:note) { Note.new(title: 'Lorem Ipsum', body: 'Lorem ipsum dolor sit amet') }

  it 'initializes a note' do
    expect(note).to be_an_instance_of(Note)
  end

  it 'has a getter called title' do
    expect(note.title).to eq('Lorem Ipsum')
  end

  it 'has a getter called body' do
    expect(note.body).to eq('Lorem ipsum dolor sit amet')
  end

  it 'has a setter called title' do
    note.title = 'Dummy Title'
    expect(note.title).to eq('Dummy Title')
  end

  it 'has a setter called body' do
    note.title = 'Dummy Body'
    expect(note.title).to eq('Dummy Body')
  end

  it 'creates a note' do
    expect(Note.create(note)).to eq('asdf')
  end

  # TODO type validation
end
