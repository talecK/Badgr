class CreateGemslots < ActiveRecord::Migration
  def self.up
    create_table :gemslots do |t|
      t.belongs_to :user
      t.timestamps
    end
  end

  def self.down
    drop_table :gemslots
  end
end

