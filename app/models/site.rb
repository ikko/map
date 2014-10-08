# encoding: utf-8
class Site < ActiveRecord::Base

  hobo_model # Don't put anything above this
  
  require 'open-uri'

  LEVEL_LIMIT = 3
    
  fields do
    name        :string
    title       :text
    description :text
    rank        :integer, :default => 0
    icon        :string
    timestamps
  end
  attr_accessible :name, :title, :description, :site_id, :state, :rank, :icon

  self.per_page = 20

  has_many :links
  
  has_many :site_words
  has_many :words, :through => :site_words

  has_many :site_users
  has_many :users, :through => :site_users
 

  def splitwords( user_id )
    if s = self.description
      words = s.gsub(/[\?\.\,\:\;\/\[\]+'<>#&@{}\\*"|@=!%$€()»]/,'').split
      @freqs    = FrequentWord.all.*.name
      words.each do |w|
        next if w.size == 1
        next if w.size > 42
        w.downcase!
        next if @freqs.include?(w)
        word = Word.find_by_name w
        if !word
          word = Word.new :name => w
          puts w
        end
        word.save
        if SiteWord.all.where( site_id: self.id, word_id: word.id).size < 1
          word.increment! :rank
          word.save
          SiteWord.create site_id: self.id, word_id: word.id
          if user_id
            WordUser.find_or_create_by_word_id_and_user_id word.id, user_id
          end
        end
      end
    end
  end

  def rank_by_links
    links = Link.all
    self.rank = links.where(site_to_id: self.id).size
  end


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
