class CreateUserAchievements < ActiveRecord::Migration
  def self.up
    create_table :user_achievements do |t|
      t.belongs_to :achievement
      t.belongs_to :user
      t.integer :status
      t.belongs_to :presenter
      t.timestamps
    end
  end

  def self.down
    drop_table :user_achievements
  end
end

