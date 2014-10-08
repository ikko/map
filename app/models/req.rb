class Req < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    url :string
    timestamps
    status :string, :default => 'unprocessed'
    manual :boolean, :default => true
  end
  attr_accessible :url, :manual, :user_id

  belongs_to :user, :creator => true

  default_scope { order('updated_at DESC') }
 
  after_create do |r|
    if r.manual
      r.process_req_manual
    else
      r.process_req_auto
    end
  end

  def process_req
    puts "process_req #{self.id} for #{self.url}"
    self.status = 'reading in progress'
    self.save
    @sites = siteread self.url, 2
    self.status = 'storing in progress, processing sites'
    self.save
    process_sites
    self.status = 'sites processed, links in progress'
    self.save
    process_links
    self.status = 'links processed, rearranging words'
    self.save
    if self.user_id
      Word.find_parrents nil
      Word.find_parrents self.user_id
    end
    self.status = 'processed'
    self.save
    puts "finished process_req #{self.id} for #{self.url}, looking deeper"
    create_auto_requests
    puts "FINISHED process_req #{self.id} for #{self.url}"
  end

  def process_sites
    @sites[:sites].each do |siteitem|        
      sites = Site.all.where( name: siteitem[:site] )
      if sites.size > 0
        site = sites.first
        site.title = siteitem[:title]
        site.description = siteitem[:description]
        site.icon = siteitem[:icon]
        site.save
      else
        site = Site.create :name => siteitem[:site], 
          :title => siteitem[:title], 
          :description => siteitem[:description], 
          :icon => siteitem[:icon]
      end
      site.rank_by_links
      if self.user_id
        SiteUser.find_or_create_by_site_id_and_user_id site.id, self.user_id
      end
      site.splitwords self.user_id
    end
    puts "process sites finished"
  end

  def process_links
    @sites[:links].each do |linkitem|
      puts linkitem.inspect
      links = Link.all.where( sitename_from: linkitem[:url_from], sitename_to: linkitem[:url_to] )
      if links.size > 0
        link = links.first
        link.name = linkitem[:text]
        link.save
      else
        site_to = Site.find_by_name linkitem[:url_to]
        site_from = Site.find_by_name linkitem[:url_from]
        if site_to and site_from
          Link.create sitename_from: linkitem[:url_from],
            sitename_to:   linkitem[:url_to],
            site_from_id:  site_from.id,
            site_to_id:    site_to.id,
            name:          linkitem[:text],
            scanned:       false
        end
      end
    end
  end

  def create_auto_requests
    if self.manual
      Link.all.not_scanned.each do |l|
        l.scanned = true
        l.save
        Req.create( :manual => false, :url => l.sitename_to, :user_id => self.user_id)
      end
    end
  end

  def process_req_manual
    self.process_req
  end
  handle_asynchronously :process_req, :priority => 22

  def process_req_auto
    self.process_req
  end
  handle_asynchronously :process_req, :priority => 33

  class UrlValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      begin
        uri = URI.parse(value)

        if !["http","https"].include?(uri.scheme)
          raise URI::InvalidURIError
        end
      rescue URI::InvalidURIError
        record.errors[attribute] << "Invalid, should begin with 'http:// or https://'"
      end
    end
  end

  validates :url, :url => true

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
    # acting_user.administrator?
    !acting_user.guest? and manual == true
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
