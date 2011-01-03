class AddGemslotIdToAchievements < ActiveRecord::Migration
  def self.up
    add_column :achievements, :gemslot_id, :integer
    add_index :achievements, :gemslot_id
  end

  def self.down
    remove_column :achievements, :gemslot_id
  end
end

