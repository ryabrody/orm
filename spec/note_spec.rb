require 'spec_helper'

describe Note do
  let(:title) { 'Lorem Ipsum' }
  let(:body) { 'Lorem ipsum dolor sit amet' }
  let(:note) { Note.new(title: title, body: body) }

  it 'initializes a note' do
    expect(note).to be_an_instance_of(Note)
  end

  it 'has a class_method called table' do
    expect(Note.table).to eq('notes')
  end

  it 'has a class_method called fields' do
    expect(Note.fields).to eq %w(id title body created_at updated_at)
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

  it 'has a getter called id' do
    note.create
    expect(note.id).to eq(1)
  end

  it 'creates a note' do
    pending('i need some help with this')
    expect { note.create }.to change{ Note.all }.by(1)
  end

  it 'reads all notes' do
    3.times { note.create }
    expect(Note.all.count).to eq(3)
  end

  it 'updates a note' do
    #expect { Counter.increment }.to change{Counter.count }.from(0).to(1)
    new_title = 'Cake pie candy'
    new_body = 'Cake pie candy soufflé carrot cake'
    expect { note.update(title: new_title, body: new_body) }.to change{ note.title }.from(title).to(new_title)
  end

  # TODO type validation
  # TODO string verhindern der datanbank beschädigen kann
end
