namespace :db do
  namespace :export do
    task :posts => :environment do
      File.open('tmp/posts.yml', 'w+') do |f|
        f.write posts = Post.all.map(&:attributes).to_yaml
      end
    end
  end
end
