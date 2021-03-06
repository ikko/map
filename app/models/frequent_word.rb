class FrequentWord < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    timestamps
  end
  attr_accessible :name

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
    # true
  end

  def update_permitted?
    acting_user.administrator?
    # true
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
