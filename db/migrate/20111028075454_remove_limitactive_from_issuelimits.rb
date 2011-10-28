class RemoveLimitactiveFromIssuelimits < ActiveRecord::Migration
  def self.up
    remove_column :issuelimits, :limitactive
  end

  def self.down
    add_column :issuelimits, :limitactive, :integer
  end
end
