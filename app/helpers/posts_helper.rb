module PostsHelper
  def permalink(post)
    date = post.published_at
    post_path(year: date.year, month: date.strftime("%m"), id: post)
  end
end
