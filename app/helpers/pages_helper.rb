module PagesHelper
  def markdown(content)
    if content
      markdown = Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new
      )
      markdown.render(content).html_safe
    end
  end

  def link_to_movie(movie)
    if movie.created_at + (2*7*24*60*60) > Time.now
      new = "<span class='new'>NEW</span>"
    else
      new = ""
    end
    raw "#{new}#{link_to movie.title, movie.details}"
  end
end
