class SiteUser < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    timestamps
  end
  attr_accessible 

  belongs_to :site
  belongs_to :user
  
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
