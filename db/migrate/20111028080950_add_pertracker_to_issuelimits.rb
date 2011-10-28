class AddPertrackerToIssuelimits < ActiveRecord::Migration
  def self.up
    add_column :issuelimits, :pertracker, :boolean, :default => 0
  end

  def self.down
    remove_column :issuelimits, :pertracker
  end
end
