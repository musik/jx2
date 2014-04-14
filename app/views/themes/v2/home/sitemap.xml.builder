xml.instruct!
xml.sitemapindex do
  @files.each do |item|
    xml.sitemap do
      xml.loc root_url +  'sitemap/' + item
    end
  end
end
