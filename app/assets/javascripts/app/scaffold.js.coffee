$ ->
  if $('.scaffold').length == 0
    return
  
  $('td', '.scaffold').find('a').each (i, el) -> 
    if $(el).text() == 'Show'
      $(el).html('<i class="fa fa-info-circle"></i>')
      $(el).addClass('btn btn-glay btn-square')
      $(el).closest('td').width(20)
    else if $(el).text() == 'Edit'
      $(el).html('<i class="fa fa-pencil-square-o"></i>')
      $(el).addClass('btn btn-glay btn-square')
      $(el).closest('td').width(20)
    else if $(el).text() == 'Destroy'
      $(el).html('<i class="fa fa-trash-o"></i>')
      $(el).addClass('btn btn-glay btn-square')
      $(el).closest('td').width(20)
   
  $('.body').find('> a').each (i, el) -> 
    if $(el).text().indexOf('New ') != -1
      $(el).addClass('btn btn-pink')
    else if $(el).text() == 'Back' or $(el).text() == 'Show' or $(el).text() == 'Edit'
      $(el).addClass('btn btn-gray')

