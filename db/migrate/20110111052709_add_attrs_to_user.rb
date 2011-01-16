class AddAttrsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :gmail, :boolean, :default => false
    add_column :users, :sms,   :boolean, :default => false
    add_column :users, :estime, :time  #email start time
    add_column :users, :eetime, :time  #email end time
    add_column :users, :sstime, :time  #sms start time
    add_column :users, :setime, :time  #sms end time
    add_column :users, :weekend, :boolean, :default => false
  end

  def self.down
    remove_column :users, :email
    remove_column :users, :sms
    remove_column :users, :estime
    remove_column :users, :eetime
    remove_column :users, :sstime
    remove_column :users, :setime
    remove_column :users, :weekend
  end
end
