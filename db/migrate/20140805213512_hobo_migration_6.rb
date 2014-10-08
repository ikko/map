class HoboMigration6 < ActiveRecord::Migration
  def self.up
    add_column :sites, :icon, :string
  end

  def self.down
    remove_column :sites, :icon
  end
end
