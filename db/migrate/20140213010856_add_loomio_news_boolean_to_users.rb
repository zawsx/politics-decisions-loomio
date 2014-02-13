class AddLoomioNewsBooleanToUsers < ActiveRecord::Migration
  def up
    add_column :users, :subscribed_to_loomio_news, :boolean, null: false, default: false
  end

  def down
    remove_column :users, :subscribed_to_loomio_news
  end
end
