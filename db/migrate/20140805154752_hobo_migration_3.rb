class HoboMigration3 < ActiveRecord::Migration
  def self.up
    change_column :words, :rank, :integer, :default => 0
  end

  def self.down
    change_column :words, :rank, :integer
  end
end
