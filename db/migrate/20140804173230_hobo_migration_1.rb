class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string   :name
      t.text     :title
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state
      t.datetime :key_timestamp
    end
    add_index :sites, [:state]

    create_table :site_words do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :words do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :links do |t|
      t.text     :name
      t.text     :url
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :site_id
    end
    add_index :links, [:site_id]

    create_table :site_links do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :sites
    drop_table :site_words
    drop_table :words
    drop_table :links
    drop_table :site_links
  end
end
