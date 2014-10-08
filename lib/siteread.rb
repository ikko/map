# encoding: utf-8

require 'open-uri'
require 'nokogiri'

class String
  
  def stripp
    begin
      s = self.strip.scrub
      s = s.gsub(/[\?\.\,\:\;\/\[\]+'<>#&@{}\\*"|@=!%$€()»]/,'')
    rescue
      return ''
    end
    return s
  end

  def shorten
    begin
      u = URI.parse self
      if u.to_s == u.scheme + '://' + u.host
        s = self + '/'
      else
        s = self
      end
    rescue
      s = self
    end
    begin
      s = s.split('#')[0]
    rescue
      s = ''
    end
    return s
  end

end





def siteread( site, level )

  @level = level
  
  @linklist = []
  @links    = []
  @sitelist = []
  @sites    = []
  
  read site, level

  return { :sites => @sitelist, :links => @linklist }

end




def read( site, level )
  return if site.include?('share?')
  return if site.include?('//ad.')
  return if site.include?('//ads.')
  return if site.include?('bookmark.')  

  site = site.to_s.shorten

  puts site

  begin
    u = URI.parse site
  rescue
    return
  end

  if u.to_s == u.scheme + '://' + u.host
    site = site + '/'
  end  

  level = level - 1

  if level > -1

    begin
      page = Nokogiri::HTML(open(site), nil, 'UTF-8')
      #      puts "read:           #{site}"
    rescue
      #      puts "could not read: #{site}"
      return
    end

    title = page.css("title")[0]
    if title
      title = title.text.stripp
    end  


    description = page.xpath("//meta[@name='description']/@content")[0]
    if description
      description = description.value.stripp
    end


    favicon = page.xpath("//link[@rel='shortcut icon']/@href")[0]
    favicon ||= page.xpath("//link[@rel='apple-touch-icon image_src']/@href")[0]
    if favicon
      begin
        icon = favicon.value.stripp
      rescue
      end
    end
    if !favicon
      favicon = u.scheme + '://' + u.host + '/favicon.ico'
      icon = favicon.stripp
    end

    if !@sites.include? site
      @sites << site
      @sitelist << { :site => site, :title => title, :description => description, :icon => icon }
    end

    if level > 0

      links = page.css("a")
      links.each do |link|
        l = link["href"].to_s.shorten

        if l and ( l[0..6] == 'http://' or l[0..7] == 'https://' )
          if !@links.include?(l) and !@sites.include?(l) 
            @links << l
            @linklist << { :url_to => l, :text => link.text.stripp, :url_from => site }
            read l, level
          end
        end
      end
    end
  end

end


