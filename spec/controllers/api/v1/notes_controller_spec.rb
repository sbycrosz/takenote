require 'spec_helper'

describe Api::V1::NotesController do
  include_context 'api_controller_context'
  let(:user){current_user}

  describe 'POST #create' do
    let(:params){{}}
    let(:note){stub_model Note, id: 132, title: 'title', content: 'content'}

    before do
      current_user.stub_chain(:notes, :create!).and_return(note)
    end

    it 'respond_with 200' do
      post :create, params
      expect(response.status).to eql(200)
    end

    it 'render newly created note' do
      post :create, params
      expected_response = 
        {
          id: note.id,
          title: note.title,
          content: note.content
        }
      expect(response.body).to include(expected_response.to_json)
    end
  end

  describe 'GET #index' do
    let(:note1){stub_model Note, id: 132, title: 'title', content: 'content'}
    let(:note2){stub_model Note, id: 134, title: 'title2', content: 'content2'}
    let(:notes){[note1, note2]}

    before do
      current_user.stub(:notes).and_return(notes)
    end

    it 'respond_with 200' do
      get :index
      expect(response.status).to eql(200)
    end

    it 'render note owned by user' do
      get :index
      expected_response = 
        [{
          id: note1.id,
          title: note1.title,
          content: note1.content
        },
        {
          id: note2.id,
          title: note2.title,
          content: note2.content
        }]
      expect(response.body).to include(expected_response.to_json)
    end
  end

  describe 'PUT #update' do
    let(:params){{id: 132}}
    let(:note){stub_model Note, id: 132, title: 'title', content: 'content'}

    before do
      current_user.stub_chain(:notes, :find).and_return(note)
      note.stub(:update!)
    end

    it 'respond_with 200' do
      put :update, params
      expect(response.status).to eql(200)
    end

    it 'render newly udpated note' do
      put :update, params
      expected_response = 
        {
          id: note.id,
          title: note.title,
          content: note.content
        }
      expect(response.body).to include(expected_response.to_json)
    end
  end

  describe 'DELETE #delete' do
    let(:params){{id: 132}}
    let(:note){stub_model Note, id: 132, title: 'title', content: 'content'}

    before do
      current_user.stub_chain(:notes, :find).and_return(note)
      note.stub(:destroy)
    end

    it 'respond_with 200' do
      delete :destroy, params
      expect(response.status).to eql(200)
    end
  end
end
