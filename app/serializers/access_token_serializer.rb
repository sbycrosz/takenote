class AccessTokenSerializer < ActiveModel::Serializer
  def attributes
    hash = { 
      access_token: object.token,
      token_type: 'bearer'
    }
    hash[:expires_in] = object.expires_in if object.expires_in
    hash[:refresh_token] = object.refresh_token if object.refresh_token
    hash
  end
end
