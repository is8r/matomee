$ ->
  if $('#notice').length == 0
    return

  $('#notice').each (i, el) -> 
    if($(el).text().length != 0)
      $(el).addClass('show')
      setInterval ->
        $(el).removeClass('show').addClass('hide')
      , 2000
