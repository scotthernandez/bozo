class AddClosedUpdatedMetric < ActiveRecord::Migration
  def self.up
    add_column :articles, :date_assigned, :datetime
    add_column :articles, :date_closed, :datetime
  end

  def self.down
    remove_column :articles, :date_assigned
    remove_column :articles, :date_closed
  end
end
