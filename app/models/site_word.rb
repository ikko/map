class SiteWord < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
    sites_count   :integer, :default => 0
  end
  attr_accessible :site_id, :word_id
  
  belongs_to :site
  belongs_to :word, :counter_cache => :sites_count

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
