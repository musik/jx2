//= require bootstrap-modal
function getSelectionText() {
    var text = "";
    if (window.getSelection) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type != "Control") {
        text = document.selection.createRange().text;
    }
    return text;
}
$(document).ready(function (){
   $('#desc').mouseup(function (e){
       name = getSelectionText()
       $('#modal').load("/yaopin/desc_preview?name=" + name,function() {
         $('#modal').modal('show')
       })
   })
});
