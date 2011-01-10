class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :thread, :limit => 40
      t.string :url,    :limit => 40
      t.string :author, :limit => 80
      t.integer :replies
      t.integer :authors
      t.date :link_time
      t.string :category, :limit => 20
      t.string :status,   :limit => 20

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
