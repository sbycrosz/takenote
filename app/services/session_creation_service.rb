class SessionCreationService
  def initialize(username, password)
    @username, @password = username, password
  end

  def create
    user = User.find_by(email: @username)
    if user && user.authenticate(@password) 
      AccessToken.issue_for(user)
    else
      raise Exceptions::AuthenticationFailed
    end
  end
end
