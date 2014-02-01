require 'spec_helper'

describe StaticController do
  describe '#index' do
    it 'render 200' do
      get :index
      expect(response.status).to eql(200)
    end
  end
end
