# A Ruby script to migrate Jekyll Posts to a custom Database

DIRECTORIES = ["tmp/blog/articles/_posts/*", "tmp/blog/startup/_posts/*",
               "tmp/blog/productivity/_posts/*", "tmp/blog/music/_posts/*",
               "tmp/blog/programming/_posts/*"]

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

  task :categories => :environment do

    # We migrate jekyll categories to a tags table
    tags = []
    DIRECTORIES.each do |dir|
      Dir[dir].each do |file|
        file = File.open(file, 'r').read
        category = export(file, "category")
        tags << category if category
      end
    end
    tags =  tags.uniq
    tags.each { |t| p Tag.create(title: t) }
  end

  task :posts => :environment do

    DIRECTORIES.each do |dir|
      Dir[dir].each do |file|
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
                           permalink: permalink)
        post.slug = slug if slug
        p post.save

        tag = Tag.find_by_title(category) if category
        post.tags << tag if tag
      end
    end
  end
end
