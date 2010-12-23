class CreateAchievements < ActiveRecord::Migration
  def self.up
    create_table :achievements do |t|
      t.string        :name
      t.integer       :user_id
      t.timestamps
    end

    add_index( :achievements, :user_id )
    add_index( :achievements, :name )
  end

  def self.down
    drop_table :achievements
  end
end

