#!/Users/pulleasy/.rbenv/shims/ruby
# A Ruby script to migrate Jekyll Posts to a custom Database
#
require 'rails'

def export(content, key)
  match = content.match( /^---.*\n#{key}: ([^\n]*).*---$/m )
  if match
    output = match[1].gsub("\"", "")
  end
end

def export_content(content)
  match = content.match /^---.*---\n*(.*)$/m
  if match
    match[1].chomp
  end
end

def export_slug(content)
  # permalink = content.match( /^---.*permalink: ([^\n]*).*---$/m )[1].gsub("\"", "")
end

Dir["tmp/blog/articles/_posts/*"].each do |post|
  post = File.open(post, 'r').read

  title = export(post, "title")
  p title if title
  permalink = export(post, "permalink")
  p permalink if permalink
  link = export(post, "link")
  p link if link
  category = export(post, "category")
  p category if category
  published = export(post, "published")
  p eval(published) if published
  date = export(post, "date")
  p date[0..-3].to_date if date
  type = export(post, "layout")
  p type if type
  p export_content(post)
end
