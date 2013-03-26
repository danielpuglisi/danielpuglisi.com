# A Ruby script to migrate Jekyll Posts to a custom Database

def export(content, key)
  match = content.match( /^---.*\n#{key}: ([^\n]*).*---$/m )
  if match
    match[1].gsub("\"", "")
  end
end

def export_content(content)
  match = content.match /^---.*---\n*(.*)$/m
  if match
    match[1].chomp
  end
end

def export_slug(content)
  match = content.match /.*\/(.*).html/
  if match
    match[1]
  end
end

namespace :migrate do
  task :posts => :environment do

    Dir["tmp/blog/articles/_posts/*"].each do |file|
      file = File.open(file, 'r').read

      title = export(file, "title")
      permalink = export(file, "permalink")
      slug = export_slug(permalink) if permalink
      link = export(file, "link")
      category = export(file, "category")
      published = export(file, "published")
      if published
        published = eval(published)
      else
        published = true
      end
      date = export(file, "date")
      date = date[0..-3].to_date if date
      type = export(file, "layout")
      content = export_content(file)

      post = Post.create(title: title, content: content,
                         published_at: date, published: published,
                         external_link: link, style: type,
                         slug: slug, permalink: permalink)
      p post
      post.tags.create(title: category)
    end
  end
end
