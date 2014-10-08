# encoding: utf-8

site = 'http://mahamudra.blog.hu/'
@level = 3

require 'open-uri'
require 'nokogiri'

@linklist = []

class String
  def stripp
    begin
      s = self.strip
    rescue
      return ''
    end
    return s
  end
end



def read( site, level, originator )

  def putta( x, level )
    spacer = ''
    (@level - level).times do spacer = spacer + '  ' end
    puts "#{spacer}#{x}"
  end
  
 
  level = level - 1

  if level > -1
    
    begin
      page = Nokogiri::HTML(open(site), nil, 'UTF-8')
    rescue
      return
    end
    
    
    putta "->: #{originator}", level
    
    
    title = page.css("title")[0]
    if title
      title = title.text.stripp
    end
    putta "t:: #{title} (#{site})", level
    

    
    description = page.xpath("//meta[@name='description']/@content")[0]
    if description
      description = description.value.stripp
    end
    putta "d:: #{description}", level

#     keywords = page.xpath("//meta[@name='keywords']/@content")[0]
#     if keywords
#       keywords = keywords.value.stripp
#     end
#     putta "k:: #{keywords}", level
 
    
    links = page.css("a")
    links.each do |link|
      if link["href"] and ( link["href"][0..6] == 'http://' or link["href"][0..7] == 'https://' )
	if !@linklist.include? link["href"]
          @linklist << link["href"]
	  read link["href"], level, link.text.stripp
	end
      end
    end

  end

end

puts "Reading site: #{site} ............................ "

read site, @level, ''

# puts @linklist

