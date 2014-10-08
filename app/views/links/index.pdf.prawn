prawn_document() do |pdf|
  @this.each {|r| pdf.text "#{r.title}\n#{r.name}\n\n"}
end
