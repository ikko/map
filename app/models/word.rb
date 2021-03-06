class Word < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    rank          :integer, :default => 0
    words_counter :integer, :default => 0
    sites_count   :integer, :default => 0
    timestamps
  end
  attr_accessible :name, :rank, :sites

  self.per_page = 42

  default_scope { order('rank DESC') }
 # default_scope { where.not(name: FrequentWord.all.*.name) }

  has_many :site_words
  has_many :sites, :through => :site_words

  belongs_to :word, :counter_cache => :words_counter  # parent id
  has_many :words   # childrens

  has_many :word_users
  has_many :users, :through => :word_users


  def self.find_parrents user_id
    if user_id
      words = User.find(user_id).words
    else
      words = Word.all
    end
    words.each do |word|
      if user_id
        wu = word.parrent user_id
      end
      if word.sites.empty?
        if user_id
          if wu.parrent_word_id
            wu.parrent_word_id = nil
            wu.save
          end
        else
          if word.word_id 
            word.word_id = nil
            word.save
          end
        end
      else
        szomszedok = word.sites.*.words.flatten.*.id
        if szomszedok.length < 2 # mi is benne vagyunk
          if user_id
            if wu.parrent_word_id
              wu.parrent_word_id = nil
              wu.save
            end
          else
            if word.word_id 
              word.word_id = nil
              word.save
            end
          end
        else
          elofordulas = szomszedok.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
          c = elofordulas.sort {|x,y| x[1]<=>y[1]}
          c.reverse!
          kovetkezo_gyakorisag = c[1][1]
          parrent_attendees = []
          c.length.times do |i|
            if c[i][0] != word.id
              if c[i][1] == kovetkezo_gyakorisag
                t = Word.find(c[i][0])
                if t.sites_count > word.sites_count 
                  parrent_attendees << t
                end
              else
                break
              end
            end
          end
          if !parrent_attendees.empty?
            pa_id = parrent_attendees.sort { |x,y| x.sites_count <=> y.sites_count}.first.id
            if user_id
              wu.parrent_word_id = pa_id
              wu.save
            else
              word.word_id = pa_id
              word.save
            end
          end
        end
      end
    end
    Word.all.each { |t| t.words_counter = t.words.count; t.save }
    system "rm -f #{Rails.root}/public/words/tree.*"
  end

  def parrent( user_id )
    WordUser.all.where( user_id: user_id, word_id: self.id ).first
  end

  def self.pump( word )
    a = []
    if word.words_counter > 0
      word.words.each do |t|
        a << pump( t )
      end
    end
    result = Hash.new
    result[:name] = word.name
    result[:id]   = word.id
    result[:children_count] = word.words_counter
    result[:sites_count]    = word.sites_count
    result[:parent_id]      = word.word_id
    result[:children]       = a
    result
  end

  def self.tree
    top = Word.find( :all, :conditions => { :word_id => nil } )
    wordtree = []
    top.each do |word|
      if word.sites_count > 0 or word.words_counter > 0
        wordtree << pump( word )
      end
    end
    wordtree
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
