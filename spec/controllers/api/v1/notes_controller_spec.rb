require 'spec_helper'

describe Api::V1::NotesController do
  include_context 'api_controller_context'
  let(:user){current_user}

  describe 'POST #create' do
    let(:params){{}}
    let(:note){stub_model Note, id: 132, title: 'title', body: 'body'}

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
          body: note.body,
          tags: [],
          updated_at: 0
        }
      expect(response.body).to include(expected_response.to_json)
    end
  end

  describe 'GET #index' do
    let(:note1){stub_model Note, id: 132, title: 'title', body: 'body'}
    let(:note2){stub_model Note, id: 134, title: 'title2', body: 'body2', tag_objects: [tag]}
    let(:tag){stub_model Tag, name: "tagname"}
    let(:notes){[note1, note2]}

    before do
      current_user.stub_chain(:notes, :include_tags).and_return(notes)
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
          body: note1.body,
          tags: [],
          updated_at: 0
        },
        {
          id: note2.id,
          title: note2.title,
          body: note2.body,
          tags: [tag.name],
          updated_at: 0
        }]
      expect(response.body).to include(expected_response.to_json)
    end
  end

  describe 'PUT #update' do
    let(:params){{id: 132}}
    let(:note){stub_model Note, id: 132, title: 'title', body: 'body'}

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
          body: note.body,
          tags: [],
          updated_at: 0
        }
      expect(response.body).to include(expected_response.to_json)
    end
  end

  describe 'DELETE #delete' do
    let(:params){{id: 132}}

    context 'when succeed' do
      let(:note){stub_model Note, id: 132, title: 'title', body: 'body'}

      before do
        current_user.stub_chain(:notes, :find).and_return(note)
        note.stub(:destroy)
      end

      it 'respond_with 200' do
        delete :destroy, params
        expect(response.status).to eql(200)
      end
    end

    context 'when failed' do
      it 'respond_with 404' do
        delete :destroy, params
        expect(response.status).to eql(404)
      end
    end
  end
end
