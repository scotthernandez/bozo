class AddCatToArticle < ActiveRecord::Migration
  def self.up
    add_column :articles, :category_id, :integer
    remove_column :articles, :category
  end

  def self.down
    add_column :articles, :category, :string, :limit => 40
    remove_column :articles, :category_id
  end
end
