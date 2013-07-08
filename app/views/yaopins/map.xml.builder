xml.instruct!
xml.urlset do
  @yaopins.each do |item|
    xml.url do
      xml.loc yaopin_url(item.wenhao)
      #xml.lastmod item.updated_at
      #xml.changefreq 
    end
  end
end
