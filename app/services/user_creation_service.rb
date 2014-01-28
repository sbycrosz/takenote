class UserCreationService
  def initialize(params)
    @user_params = params
  end

  def create
    user = User.create!(@user_params)
    token = AccessToken.issue_for(user)
    return SignInResponse.new(user, token)
  end
end
