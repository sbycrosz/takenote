namespace :doorkeeper do
  desc 'Create initial doorkeeper application'
  task create_application: :environment do
    application = Doorkeeper::Application.first
    unless application
      sql = "INSERT INTO `oauth_applications` (`name`, `uid`, `secret`, `redirect_uri`, `created_at`, `updated_at`) VALUES  ('takenote', 'b0a0dbf6d680d496d56052039c0c743ba3a2031dc68aadc702c0521c3401f97b', 'a7fbbcf767ebdd5dc3b61194d5ac6f5bd1d46895f17f7167af32f8fdd5113f6f', 'urn:ietf:wg:oauth:2.0:oob', '2013-11-15 09:59:29', '2013-11-15 09:59:29');"
      ActiveRecord::Base.connection.execute(sql) 
    end

    application  = Doorkeeper::Application.first
    client_token = Doorkeeper::AccessToken.find_by(application_id: application.id, resource_owner_id: nil)
    unless client_token
      sql = "INSERT INTO `oauth_access_tokens` (`application_id`, `token`, `created_at`) VALUES  ('#{application.id}', '370086868c8e3a5adb1b63679eaf802fec5cf839bbd99eaa1e3f14f138d66a96', '2013-11-15 09:59:29');"
      ActiveRecord::Base.connection.execute(sql) 
    end
  end
end