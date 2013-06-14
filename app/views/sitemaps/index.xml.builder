xml.instruct!
xml.urlset 'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @buildings.each do |b|
    xml.url {
      xml.loc("http://www.trackingspace.com/buildings/#{b.slug}")
      xml.changefreq("daily")
    }
  end
end