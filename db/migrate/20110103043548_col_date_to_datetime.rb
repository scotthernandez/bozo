class ColDateToDatetime < ActiveRecord::Migration
  def self.up
    change_column :articles, :link_time, :datetime
  end

  def self.down
  end
end
