class TimeHandling < ActiveRecord::Migration
  def self.up
    remove_column :users, :estime
    remove_column :users, :eetime
    remove_column :users, :sstime
    remove_column :users, :setime

    add_column :users, :estime, :string, :limit => 5
    add_column :users, :eetime, :string, :limit => 5
    add_column :users, :sstime, :string, :limit => 5
    add_column :users, :setime, :string, :limit => 5

  end

  def self.down
  end
end
