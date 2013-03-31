class PagesController < ApplicationController

  def home
    @title = "Entrepreneur. Designer. Developer."
  end

  def work
    @title = "Work"
    @description = "Ruvetia, Codegestalt, Kreatify, Budo Sport Center, Krav Maga Self Protect, Rails Girls, Bridge, Froburg"
  end

  def recommendations
    result = ImdbLists.fetch("http://www.imdb.com/list/aw8wqGRn0LI/")
    @movies = result.movies.sort_by{|x| x.rating}.reverse
  end
end
