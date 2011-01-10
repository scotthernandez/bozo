class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name,  :limit => 40
      t.string :email, :limit => 40
      t.string :phone, :limit => 20
      t.string :chat,  :limit => 40
      t.boolean :email_y
      t.boolean :phone_y
      t.boolean :chat_y

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
