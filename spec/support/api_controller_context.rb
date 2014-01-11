shared_context 'api_controller_context' do
  let(:current_user) { stub_model User, email: 'sambya@aryasa.net', id: 42, name: 'sam' }
  let(:token) { double :accessible? => true, resource_owner_id: current_user.id }

  before do
    controller.stub(:doorkeeper_token).and_return(token)
    User.stub(:find).with(current_user.id).and_return(current_user)
    request.env["HTTP_ACCEPT"] = 'application/json'
  end
end
