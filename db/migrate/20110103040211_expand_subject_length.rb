class ExpandSubjectLength < ActiveRecord::Migration
  def self.up
    change_column(:articles, :subject, :string, :limit=>140)
  end

  def self.down
  end
end
