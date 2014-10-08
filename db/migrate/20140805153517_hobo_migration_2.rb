class HoboMigration2 < ActiveRecord::Migration
  def self.up
    add_column :site_words, :site_id, :integer
    add_column :site_words, :word_id, :integer

    add_column :words, :rank, :integer

    add_index :site_words, [:site_id]
    add_index :site_words, [:word_id]
  end

  def self.down
    remove_column :site_words, :site_id
    remove_column :site_words, :word_id

    remove_column :words, :rank

    remove_index :site_words, :name => :index_site_words_on_site_id rescue ActiveRecord::StatementInvalid
    remove_index :site_words, :name => :index_site_words_on_word_id rescue ActiveRecord::StatementInvalid
  end
end
