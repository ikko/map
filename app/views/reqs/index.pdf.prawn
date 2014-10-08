prawn_document() do |pdf|
  @this.each {|r| pdf.text r.url}
end
