module PostsHelper
  def permalink(post, options={})
    date = post.published_at
    options.merge!(id: post)
    options.merge!(year: date.year)
    options.merge!(month: date.strftime("%m"))
    post_path(options)
  end

  def render_layout(post)
    if post.style == "link"
      render "posts/link", post: post
    else
      render "posts/post", post: post
    end
  end
end
