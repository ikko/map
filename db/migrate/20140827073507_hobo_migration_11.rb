class HoboMigration11 < ActiveRecord::Migration
  def self.up
    add_column :words, :words_counter, :integer, :default => 0
    add_column :words, :sites_count, :integer, :default => 0
  end

  def self.down
    remove_column :words, :words_counter
    remove_column :words, :sites_count
  end
end
