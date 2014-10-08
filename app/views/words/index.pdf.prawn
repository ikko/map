prawn_document() do |pdf|
  @this.each {|r| pdf.text r.name}
end
