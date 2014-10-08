class WordUser < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end
  attr_accessible :word_id, :user_id, :parrent_word_id
  
  belongs_to :word
  belongs_to :user
  belongs_to :parrent_word, :class_name => 'Word'
  
  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
    true
  end

  def update_permitted?
    acting_user.administrator?
    true
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
