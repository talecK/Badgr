class AddRoleToMembershipAndRemoveGroupCreatorAndGroupAdmin < ActiveRecord::Migration
  def self.up
    add_column :memberships, :role, :string, :default => "member"
    remove_column :memberships, :group_creator
    remove_column :memberships, :group_admin
  end

  def self.down
    remove_column :memberships, :role
    add_column :memberships, :group_creator, :boolean, :default => false
    add_column :memberships, :group_admin, :boolean, :default => false
  end
end

