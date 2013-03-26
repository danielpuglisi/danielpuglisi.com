module PagesHelper
  def markdown(content)
    if content
      markdown = Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new
      )
      markdown.render(content).html_safe
    end
  end
end
