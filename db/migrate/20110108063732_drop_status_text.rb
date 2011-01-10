class DropStatusText < ActiveRecord::Migration
  def self.up
    remove_column :articles, :status
  end

  def self.down
    add_column :articles, :status, :string, :limit => 40
  end
end
