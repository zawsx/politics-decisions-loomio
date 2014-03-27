class FixPrivacy < ActiveRecord::Migration
  class Group < ActiveRecord::Base
  end

  def up
    add_column :groups, :visible, :boolean, default: true, null: false
    add_column :groups, :discussion_privacy, :string, default: nil
    rename_column :groups, :viewable_by_parent_members, :visible_to_parent_members
    add_column :groups,  :members_can_add_members, :boolean, default: false, null: false
    add_index :groups, :visible
    add_column :groups, :membership_granted_upon, :string, default: nil

    Group.reset_column_information

    puts "Converting group.privacy setting"
    progress_bar = ProgressBar.create( format: "(\e[32m%c/%C\e[0m) %a |%B| \e[31m%e\e[0m ", progress_mark: "\e[32m/\e[0m", total: Group.count )

    Group.find_each do |group|
      case 
      when ['public', 'everyone'].include?(group.privacy)
        group.visible = true
        group.discussion_privacy = 'public_or_private'
        group.membership_granted_upon = 'approval'
      when ['private'].include?(group.privacy)
        group.visible = true
        group.discussion_privacy = 'public_or_private'
        group.membership_granted_upon = 'approval'
      when ['hidden', 'secret', 'members', 'parent_group_members'].include?(group.privacy)
        group.visible = false
        group.discussion_privacy = 'private_only'
        group.membership_granted_upon = 'invitation'
      else
        puts "weird privacy group #{group.id} value #{group.privacy}"
      end

      case group.members_invitable_by
      when 'members'
        group.members_can_add_members = true
      when 'admins'
        group.members_can_add_members = false
      end

      group.save
      progress_bar.increment
    end

    change_column :groups, :discussion_privacy, :string, default: nil, null: false
    change_column :groups, :membership_granted_upon, :string, default: nil, null: false


  end

  def down
    remove_column :groups, :members_can_add_members
    remove_column :groups, :private_discussions_only
    remove_column :groups, :visible
    rename_column :groups, :visible_to_parent_members, :viewable_by_parent_members
  end
end
