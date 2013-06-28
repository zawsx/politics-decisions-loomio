namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    %w(User Discussion Membership Motion Vote).each(&:delete_all)

    # Create an admin
    User.create!(email: 'admin@loomio.org', password: "password", name: 'Administrator')
    admin = User.where('email = ?', 'admin@loomio.org').first

    # Add some users...
    10000.times.each do
      User.create!(email: Faker::Internet.email, password: "password", name: Faker::Name.name)
    end


    # Create some groups...
    10.times.each {Group.create! name: Faker::Address.city}

    # ... and subgroups
    100.times.each {Group.create! name: Faker::Address.street_name, parent_id: Group.where('parent_id IS NULL').first(:order => "RANDOM()").id}

    # All users get subscribed to 5 groups
    User.for_each do |user|
      Group.where('parent_id IS NULL', :order => "RANDOM()", :limit => 5).each do |group|
        m = Membership.create group_id: group.id
        m.update_attribute 'user_id', user.id
        m.promote_to_member!
      end
    end
  end
end
