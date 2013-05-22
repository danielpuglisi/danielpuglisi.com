$ ->
  # jQuery.fn.outerHTML = ->
  #   return jQuery('<div />').append(this.eq(0).clone()).html()

  $(".fields ul li").first().animate("opacity": 1)
  i = 0
  setInterval ->

    index = i % 3
    $(".fields ul li").eq(index).animate("opacity": 0)
    i = i + 1

    index = i % 3
    $(".fields ul li").eq(index).animate("opacity": 1)

    # $(".fields ul").append($(".fields ul li").first().outerHTML())
    # $(".fields ul li").last().removeAttr("style")
    # $(".fields ul li").first().fadeOut ->
    #   $(@).remove()
    #   $(".fields ul li").first().fadeIn()

  , 4000
  # $(".fields ul li").next().index()
