class LinksRenderer < Liquid::Tag
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include PagesHelper
  attr_accessor :output_buffer

  def initialize(tag_name, params, tokens)
     super
     args = params.split(",").map(&:strip)
     @issue = args[0]
     @tag   = args[1]
  end

  def render(context)
    output = content_tag(:ul) do
      links ||= ""
      Issue.find_by_number(@issue).links.joins(:tags).where('tags.name = ?', @tag).order(:issue_order).each do |link|
        links += content_tag :li do
          link_output  = link_to link.name, link.url
          link_output += tag :br
          link_output += markdown(link.description)
          link_output.html_safe
        end
      end
      links.html_safe
    end
    output
  end
end

Liquid::Template.register_tag('links', LinksRenderer)
