class SignInResponse
  include ActiveModel::Serialization
  include ActiveModel::SerializerSupport
  
  attr_accessor :user, :access_token

  def initialize(user, access_token)
    @user, @access_token = user, access_token
  end
end
