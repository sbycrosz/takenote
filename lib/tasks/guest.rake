namespace :guest do
  desc 'Destroy all guest account'
  task destroy_all: :environment do
    p "Removing #{User.guest.count} guest user(s).."
    User.guest.destroy_all
  end
end