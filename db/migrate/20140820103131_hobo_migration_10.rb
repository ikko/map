class HoboMigration10 < ActiveRecord::Migration
  def self.up
    add_column :links, :sitename_from, :text
    add_column :links, :sitename_to, :text
  end

  def self.down
    remove_column :links, :sitename_from
    remove_column :links, :sitename_to
  end
end
