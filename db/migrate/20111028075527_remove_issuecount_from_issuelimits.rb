class RemoveIssuecountFromIssuelimits < ActiveRecord::Migration
  def self.up
    remove_column :issuelimits, :issuecount
  end

  def self.down
    add_column :issuelimits, :issuecount, :integer
  end
end
