class AddIndexToMotions < ActiveRecord::Migration
  def change
    add_index :motions, [:discussion_id, :closed_at]
  end
end
