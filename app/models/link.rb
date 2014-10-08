class Link < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :text
    timestamps
    sitename_from :text
    sitename_to   :text
    scanned :boolean, :default => false
  end
  attr_accessible :name, :sitename_from, :sitename_to, :site_from_id, :site_to_id, :scanned

  belongs_to :site_from, :class_name => 'Site'
  belongs_to :site_to, :class_name => 'Site'
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |record|
        csv << record.attributes.values_at(*column_names)
      end
    end
  end

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
