class MakeUserBelongToAchievementAndRemoveAchievementsAssocWithGemslot < ActiveRecord::Migration
  def self.up
    add_column :users, :gem_id, :integer
    add_index :users, :gem_id
    remove_column :achievements, :gemslot_id
  end

  def self.down
    remove_column :users, :gem_id
    add_column :achievements, :gemslot_id, :integer
  end
end

