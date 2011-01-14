class CreateMembershipObservers < ActiveRecord::Migration
  def self.up
    create_table :membership_observers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :membership_observers
  end
end
