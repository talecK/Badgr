class CreateGemslots < ActiveRecord::Migration
  def self.up
    create_table :gemslots do |t|
      t.integer :user_id
      t.timestamps
    end

    add_index :gemslots, :user_id
  end

  def self.down
    drop_table :gemslots
  end
end

