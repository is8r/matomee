$ ->
  if $('.js-sidr-trigger').length == 0
    return
  
  $('.js-sidr-trigger').sidr({
    name: 'sidr',
    onOpen: () ->
      $('.js-sidr-trigger').addClass('open')
    onClose: () ->
      $('.js-sidr-trigger').removeClass('open')
  })