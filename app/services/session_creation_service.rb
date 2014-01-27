class SessionCreationService
  def initialize(username, password)
    @username, @password = username, password
  end

  def create
    user = User.find_by(email: @username)
    if user && user.authenticate(@password) 
      token = AccessToken.issue_for(user)
      SignInResponse.new(user, token)
    else
      raise Exceptions::AuthenticationFailed
    end
  end
end
