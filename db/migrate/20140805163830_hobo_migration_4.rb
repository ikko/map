class HoboMigration4 < ActiveRecord::Migration
  def self.up
    add_column :sites, :rank, :integer, :default => 0

    add_column :words, :word_id, :integer

    add_index :words, [:word_id]
  end

  def self.down
    remove_column :sites, :rank

    remove_column :words, :word_id

    remove_index :words, :name => :index_words_on_word_id rescue ActiveRecord::StatementInvalid
  end
end
