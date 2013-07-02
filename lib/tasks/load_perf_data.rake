namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'

    [User, Discussion, Membership, Motion, Vote].each(&:destroy_all)



    # Create an admin
    User.create!(email: 'admin@loomio.org', password: "password", name: 'Administrator')
    admin = User.where('email = ?', 'admin@loomio.org').first
    # Add some users...


    10.times.each do
      User.create!(email: Faker::Internet.email, password: "password", name: Faker::Name.name)
    end

    # Create some groups...
    10.times.each{Group.create! name: Faker::Address.city}

    # ... and subgroups
    100.times.each{Group.create! name: Faker::Address.street_name, parent_id: pick(Group, 'parent_id IS NULL').id}

    # All users get subscribed to 5 groups...
    User.find_each do |user|
      pick(Group, 'parent_id IS NULL', 5).each do |group|
        m = Membership.create group_id: group.id
        m.update_attribute 'user_id', user.id
        m.promote_to_member!
        
        # ... and their subgroups
        group.subgroups.each do |sg|
          m = Membership.create group_id: sg.id
          m.update_attribute 'user_id', user.id
          m.promote_to_member!
        end
      end
    end

    # Add 15 discussions to all groups
    Group.find_each do |group|
      15.times.each do 
        d = Discussion.create group_id: group.id, title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph
        d.update_attribute 'author_id', pick(User).id
      end
    end

    # Add 60 comments to half of the discussions
    Discussion.where('id % 2 = 0') do |discussion|
      60.times.each do 
        c = Comment.create body: Faker::Lorem.sentences
        c.update_attribute 'user_id', pick(User).id
      end
    end
    
    # We could also add proposals votes etc... But it's not so relvant for the performance environnment at the moment
  end

  def pick(model_class, constraint = nil, limit = 1)
    result = model_class.order('RANDOM()').where(constraint).limit(limit)
    result = result.first if limit == 1
    result
  end
end
