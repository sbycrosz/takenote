class UserCreationService
  def initialize(params = {})
    @user_params = params
  end

  def create
    User.create!(@user_params).tap do |user|
      user.create_welcome_notes
      token = AccessToken.issue_for(user)
      return SignInResponse.new(user, token)
    end
  end

  def create_guest_account
    User.create_guest_account.tap do |user|
      user.create_welcome_notes
      token = AccessToken.issue_for(user)
      return SignInResponse.new(user, token)
    end
  end
end
