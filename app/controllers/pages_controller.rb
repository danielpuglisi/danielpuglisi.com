class PagesController < ApplicationController

  def home
  end

  def work
    @title = "Work"
    @description = "Creator of Ruvetia, Codegestalt, Kreatify, Budo Sport Center, Krav Maga Self Protect, Rails Girls, Bridge, Froburg."
  end

  def recommendations
    @title  = "Recommendations"
    result  = ImdbLists.fetch("http://www.imdb.com/list/aw8wqGRn0LI/")
    @movies = result.movies.sort_by{|x| x.rating}.reverse
  end

  def sitemap
    @posts = Post.published
    @tags  = @posts.tag_counts
  end
end
