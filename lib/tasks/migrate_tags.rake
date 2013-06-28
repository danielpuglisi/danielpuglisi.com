class PostsTags < ActiveRecord::Base
end

namespace :migrate do
  task :tags => :environment do
    Post.all.each do |post|
      tag_ids = PostsTags.where(post_id: post.id).map(&:tag_id)
      tag_names = OldTag.where(id: tag_ids).map(&:title)
      post.tag_list = tag_names.join(", ")
      post.save
    end
    Post.tag_counts.map(&:save)
  end
end
