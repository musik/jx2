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
function chaxun(){
  q = $('#q').val();
  if(q == '') return;
  qby = $('#qby').val();
  if(qby == 'yaopin'){
    path = '/yaopin/search'
  }else{
    path = '/pihao/search'
  }
  url = "http://" + window.location.host + path + "?q=" + q;
  window.location.href  = url;
  return false;
}
