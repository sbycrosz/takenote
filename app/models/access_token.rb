class AccessToken < Doorkeeper::AccessToken
  def self.issue_for(resource_owner)
    token = self.where(resource_owner_id: resource_owner.id).first_or_create do |token|
      token.application_id = 1
      token.expires_in = Doorkeeper.configuration.access_token_expires_in
      token.use_refresh_token = Doorkeeper.configuration.refresh_token_enabled?
    end
    token.update(created_at: Time.now) if token.expired?
    token
  end
end
