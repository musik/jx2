//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//= require bootstrap-collapse

$(function(){
  $('dl.az dt').on('hover',function(){
    $(this).parent().find('.active').removeClass('active')
    $(this).addClass('active')
    $(this).next().addClass('active')
  })
})
