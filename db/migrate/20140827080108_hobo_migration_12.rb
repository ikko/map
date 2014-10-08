class HoboMigration12 < ActiveRecord::Migration
  def self.up
    add_column :site_words, :sites_count, :integer, :default => 0
  end

  def self.down
    remove_column :site_words, :sites_count
  end
end
