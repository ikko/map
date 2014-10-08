class HoboMigration14 < ActiveRecord::Migration
  def self.up
    remove_column :sites, :state
    remove_column :sites, :key_timestamp

    add_column :links, :scanned, :boolean, :default => false

    add_column :reqs, :manual, :boolean, :default => true

    remove_index :sites, :name => :index_sites_on_state rescue ActiveRecord::StatementInvalid
  end

  def self.down
    add_column :sites, :state, :string
    add_column :sites, :key_timestamp, :datetime

    remove_column :links, :scanned

    remove_column :reqs, :manual

    add_index :sites, [:state]
  end
end
