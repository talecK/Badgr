class AddCreatorToMembership < ActiveRecord::Migration
  def self.up
    add_column :memberships, :group_creator, :boolean, :default => false
  end

  def self.down
    remove_column :memberships, :group_creator
  end
end

