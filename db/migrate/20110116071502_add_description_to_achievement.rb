class AddDescriptionToAchievement < ActiveRecord::Migration
  def self.up
    add_column :achievements, :description, :string
    add_column :achievements, :requirements, :string
  end

  def self.down
    remove_column :achievements, :description
    remove_column :achievements, :requirements
  end
end

