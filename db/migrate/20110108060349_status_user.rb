class StatusUser < ActiveRecord::Migration
  def self.up
    add_column :articles, :status_id, :integer
  end

  def self.down
    remove_column :articles, :status_id
  end
end
