class HoboMigration9 < ActiveRecord::Migration
  def self.up
    add_column :links, :site_from_id, :integer
    add_column :links, :site_to_id, :integer
    remove_column :links, :url
    remove_column :links, :site_id

    remove_index :links, :name => :index_links_on_site_id rescue ActiveRecord::StatementInvalid
    add_index :links, [:site_from_id]
    add_index :links, [:site_to_id]
  end

  def self.down
    remove_column :links, :site_from_id
    remove_column :links, :site_to_id
    add_column :links, :url, :text
    add_column :links, :site_id, :integer

    remove_index :links, :name => :index_links_on_site_from_id rescue ActiveRecord::StatementInvalid
    remove_index :links, :name => :index_links_on_site_to_id rescue ActiveRecord::StatementInvalid
    add_index :links, [:site_id]
  end
end
