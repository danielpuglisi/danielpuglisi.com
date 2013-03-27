class PagesController < ApplicationController

  def home
    @title = "Entrepreneur. Designer. Developer."
  end

  def work
    @title = "Work"
    @description = "Ruvetia, Codegestalt, Kreatify, Budo Sport Center, Krav Maga Self Protect, Rails Girls, Bridge, Froburg"
  end
end
