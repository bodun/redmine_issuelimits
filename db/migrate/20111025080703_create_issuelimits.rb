class CreateIssuelimits < ActiveRecord::Migration
  def self.up
    create_table :issuelimits do |t|
      t.column :projectid, :integer
      t.column :limitactive, :integer
      t.column :issuecount, :integer
    end
  end

  def self.down
    drop_table :issuelimits
  end
end
