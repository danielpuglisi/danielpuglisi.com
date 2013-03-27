module PostsHelper
  def permalink(post)
    date = post.published_at
    post_path(year: date.year, month: date.strftime("%m"), id: post)
  end

  def render_layout(post)
    if post.style == "link"
      render "posts/link", post: post
    else
      render "posts/post", post: post
    end
  end
end
