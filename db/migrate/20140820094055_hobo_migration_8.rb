class HoboMigration8 < ActiveRecord::Migration
  def self.up
    create_table :reqs do |t|
      t.string   :url
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :status, :default => "unprocessed"
      t.integer  :user_id
    end
    add_index :reqs, [:user_id]
  end

  def self.down
    drop_table :reqs
  end
end
