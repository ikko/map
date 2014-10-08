class HoboMigration7 < ActiveRecord::Migration
  def self.up
    create_table :word_users do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :word_id
      t.integer  :user_id
    end
    add_index :word_users, [:word_id]
    add_index :word_users, [:user_id]

    create_table :site_users do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :site_id
      t.integer  :user_id
    end
    add_index :site_users, [:site_id]
    add_index :site_users, [:user_id]
  end

  def self.down
    drop_table :word_users
    drop_table :site_users
  end
end
