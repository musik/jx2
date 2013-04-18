//= require jquery
//= require jquery_ujs
//= require bootstrap-alert
//xxx= require jquery.ui.autocomplete
//xxx= require ./lib/jquery-ui-1.8.20.custom.min.js

//xxxx= require_tree .
$(function () {
    //$("#q").autocomplete({
        //source: '/pihao/auto_complete',
        //focus: function(){
          //return false;
        //},
        //select: function(event, ui) {
          //if (ui.item.value == "0") return false;
          //window.location.href = ui.item.value
          //return false
        //}
    //});
    //load_yaofang()
    //$.getScript('http://cbjs.baidu.com/js/m.js',function(){
      //loadIfExist('458022','slotb')
      //loadIfExist('543114','slotf')
    //})
})
function loadIfExist(aid,id){
  if($("#" + id).length == 1){
    BAIDU_CLB_fillSlotAsync(aid,id)
  }
}
function reverse(s){
    return s.split("").reverse().join("");
}
function track_url(url,ref){
  $(function(){
    $.post(url,{"referer": ref})
  })
}
function track_data(class_name,name,ref){
  $(function(){
    $.post("/" + class_name + "/" + name + "/track",{"referer": reverse(ref)})
  })
}
function load_yaofang(){
  var links = [
  //'<a onclick="_hmt.push([\'_trackEvent\', \'yaofang\', \'click\', \'kaixinren\'])" href="http://count.chanet.com.cn/click.cgi?a=122417&d=309983&u=&e=&url=http%3A%2F%2Fwww.360kxr.com%2F" target="_blank"><IMG SRC="http://file.chanet.com.cn/image.cgi?a=122417&d=309983&u=&e=" width="1" height="1"  border="0">开心人网上药房</a>',
  '<a onclick="_hmt.push([\'_trackEvent\', \'yaofang\', \'click\', \'jinxiang\'])" href="http://count.chanet.com.cn/click.cgi?a=122417&d=309984&u=&e=&url=http%3A%2F%2Fwww.jxdyf.com%2F" target="_blank"><IMG SRC="http://file.chanet.com.cn/image.cgi?a=122417&d=309984&u=&e=" width="1" height="1"  border="0">金象大药房</a>'
  //'<a  onclick="_hmt.push([\'_trackEvent\', \'yaofang\', \'click\', \'jiuzhou\'])" href="http://count.chanet.com.cn/click.cgi?a=122417&d=309985&u=&e=&url=http%3A%2F%2Fwww.dada360.com%2F" target="_blank"><IMG SRC="http://file.chanet.com.cn/image.cgi?a=122417&d=309985&u=&e=" width="1" height="1"  border="0">九洲网上药店</a>'
  ]
  $('#yaofang').html(links.join(' / '))
  $('#yaofang').prepend("网上药房: ")
}
