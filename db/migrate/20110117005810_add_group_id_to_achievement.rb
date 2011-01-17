class AddGroupIdToAchievement < ActiveRecord::Migration
  def self.up
    add_column :achievements, :group_id, :integer
    add_index :achievements, :group_id
  end

  def self.down
    remove_column :achievements, :group_id
  end
end

