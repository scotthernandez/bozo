class AddSmsNumber < ActiveRecord::Migration
  def self.up
    add_column :users, :sms_address, :string, :limit => 30
  end

  def self.down
    remove_column :users, :sms_address
  end
end
