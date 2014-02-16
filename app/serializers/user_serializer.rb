class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email

  def attributes
    hash = super  
    if object.guest?
      hash[:guest] = object.guest?
    end
    return hash
  end
end
