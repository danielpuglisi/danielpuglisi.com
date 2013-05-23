xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  xml.url do
    xml.loc "http://danielpuglisi.com"
    xml.priority 1.0
  end

  xml.url do
    xml.loc work_url
    xml.priority 0.9
  end

  xml.url do
    xml.loc articles_url
    xml.priority 0.9
  end

  xml.url do
    xml.loc recommendations_url
    xml.priority 0.9
  end

  xml.url do
    xml.loc archive_url
    xml.priority 0.9
  end

  @posts.each do |post|
    xml.url do
      xml.loc "http://danielpuglisi.com#{permalink(post)}"
      xml.lastmod post.updated_at.to_date
      xml.priority 0.9
    end
  end

  @tags.each do |tag|
    xml.url do
      xml.loc tag_url(tag)
      xml.priority 0.9
    end
  end

end
