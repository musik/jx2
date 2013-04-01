//= require jquery
//= require jquery_ujs
//= require ./lib/jquery-ui-1.8.20.custom.min.js

$(function () {
    $("#q").autocomplete({
        source: '/bdapp/auto_complete',
        focus: function(){
          return false;
        },
        select: function(event, ui) {
        	if (ui.item.value == "0") return false;
//        	console.log( ui.item)
        	window.location.href = ui.item.value
        	return false

        }
    });
})
