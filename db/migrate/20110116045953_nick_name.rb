class NickName < ActiveRecord::Migration
  def self.up
    add_column :users, :nick, :string, :limit =>12
  end

  def self.down
  end
end
