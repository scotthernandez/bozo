class AddSubject < ActiveRecord::Migration
  def self.up
    add_column :articles, :subject, :string, :limit=>80
  end

  def self.down
    remove_column :articles, :subject
  end
end
