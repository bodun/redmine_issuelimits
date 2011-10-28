class CreateLimits < ActiveRecord::Migration
  def self.up
    create_table :limits do |t|
      t.column :issuelimit_id, :integer
      t.column :trackerid, :integer
      t.column :limitactive, :integer
      t.column :issuecount, :integer
    end
  end

  def self.down
    drop_table :limits
  end
end
