module ApplicationHelper

  def description
    @description.nil? ? "Daniel Puglisi is a Swiss Designer and Web Developer. He is the Co-Founder of Codegestalt, Kreatify and a Photography enthusiast." : truncate(Sanitize.clean(markdown(@description)), length: 154, separator: " ").strip.gsub("\n", "")
  end
end
