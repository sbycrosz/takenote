class SignInResponseSerializer < ActiveModel::Serializer
  has_one :user
  has_one :access_token
end
