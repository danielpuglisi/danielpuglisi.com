module PagesHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ["code", language, sha].join('-') do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(filter_html: false)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    if text
      Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
  end

  def liquidize(text)
    Liquid::Template.parse(text).render
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
