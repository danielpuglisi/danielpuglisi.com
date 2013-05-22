$ ->
  $(".works li").hover ->
    $("a", @).stop(true,true).fadeIn('fast')
  , ->
    $('a', @).fadeOut('fast')
