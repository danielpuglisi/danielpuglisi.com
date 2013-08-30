namespace :migrate do
  task :issues => :environment do

    (1..9).each do |i|
      p "Migrating to issue ##{i}"
      post_content = Post.find_by_title("Friday is Webday Issue ##{i}").content

      issue = Issue.find_by_number(i)
      issue.body = post_content
      issue.published = true
      issue.save
    end

  end
end
