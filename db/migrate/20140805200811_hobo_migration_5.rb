class HoboMigration5 < ActiveRecord::Migration
  def self.up
    create_table :frequent_words do |t|
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :frequent_words
  end
end
