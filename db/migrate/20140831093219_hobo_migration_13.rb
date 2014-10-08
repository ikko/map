class HoboMigration13 < ActiveRecord::Migration
  def self.up
    add_column :word_users, :parrent_word_id, :integer

    add_index :word_users, [:parrent_word_id]
  end

  def self.down
    remove_column :word_users, :parrent_word_id

    remove_index :word_users, :name => :index_word_users_on_parrent_word_id rescue ActiveRecord::StatementInvalid
  end
end
