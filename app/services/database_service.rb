class DatabaseService

  def self.strip_private_data
    unless Rails.env.production?
      print "STRIPPING PRIVATE DATA\n"
      print "///////////////////////////////////////////////////"

      start_time = Time.now
      p start_time

      destroy_non_public_groups
      destroy_archved_groups
      sanitize_users
      destroy_invitations

      print "\n///////////////////////////////////////////////////\n"
      print "DONE\n"
    end
  end


  private

  def self.destroy_non_public_groups
    count = Group.unscoped.where('privacy != ?', 'public').count
    progress_bar = ProgressBar.create( format: "(\e[32m%c/%C\e[0m) %a |%B| \e[31m%e\e[0m ", progress_mark: "\e[32m/\e[0m", total: count )
    print "\n> Destroying non-public groups (#{count}) & content \n"
    Group.unscoped.where('privacy != ?', 'public').find_each do |g|
      g.destroy
      progress_bar.increment
    end
  end

  def self.destroy_archved_groups
    count = Group.unscoped.where('archived_at IS NOT NULL').count
    progress_bar = ProgressBar.create( format: "(\e[32m%c/%C\e[0m) %a |%B| \e[31m%e\e[0m ", progress_mark: "\e[32m/\e[0m", total: count )
    print "\n> Destroying archived groups (#{count}) & content\n"
    Group.unscoped.where('archived_at IS NOT NULL').find_each do |g|
      g.destroy
      progress_bar.increment
    end
  end

  def self.sanitize_users
    count = User.unscoped.count
    progress_bar = ProgressBar.create( format: "(\e[32m%c/%C\e[0m) %a |%B| \e[31m%e\e[0m ", progress_mark: "\e[32m/\e[0m", total: count )
    print "\n> Sanitizing user emails and passwords (#{count})\n"
    User.unscoped.find_each do |user|
      user.update_attributes(email: "#{user.id}@fake.loomio.org", password: 'password')
      progress_bar.increment
    end
  end

  def self.destroy_invitations
    count = Invitation.unscoped.count
    progress_bar = ProgressBar.create( format: "(\e[32m%c/%C\e[0m) %a |%B| \e[31m%e\e[0m ", progress_mark: "\e[32m/\e[0m", total: count )
    print "\n> Destroying ivitations (#{count})\n"
    Invitation.unscoped.find_each do |i|
      i.destroy
      progress_bar.increment
    end
  end


  # def create_deletion_tree_for(model, parent_associations = [])
  #   relevant_reflections = dependent_reflections(model)
  #   return 'end' if relevant_reflections.empty?

  #   model_associations = {}

  #   relevant_reflections.each do |v|
  #     association_name = v.name
  #     association_model = (v.options[:class_name] || v.name.to_s.classify).constantize

  #     if parent_associations.include? association_name
  #       model_associations[association_name] = "..."
  #     else
  #       new_parent_associations = parent_associations + [association_name]
  #       model_associations[association_name] = create_deletion_tree_for(association_model, new_parent_associations)
  #     end
  #   end

  #   model_associations
  # end


  # def dependent_reflections(model)
  #   model.reflections.values.select { |v| v.macro == :has_many && v.options[:dependent] == :destroy }
  # end

  # create_deletion_tree_for(Group)
  # dependent_models = dependent_reflections(Group).map { |r| (r.options[:class_name] || r.name.to_s.classify).constantize }
  # dependent_models.each { |m| create_deletion_tree_for(m) }

end
