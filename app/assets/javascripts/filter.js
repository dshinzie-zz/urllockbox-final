
$(document).ready(function(){
  $("#search").keyup(function(){
    var rows = $('tbody tr').hide();

    if (this.value.length) {
      var data = this.value.split(" ");

      $.each(data, function (index, value) {
        rows.filter(function(){
          return $(this).text().toLowerCase().indexOf(value.toLowerCase()) > -1;
        }).show();
      });
    } else {
      rows.show();
    }
  });

  $("#unread-links").on("click", function(event){
    var tRows = $('tbody tr');

    for (var i = 0; i < tRows.length; i++) {
      if($(tRows[i]).find('.read-status').text() == "true"){
        $(tRows[i]).hide();
      } else {
        $(tRows[i]).show();
      }
    }
  });

  $("#read-links").on("click", function(event){
    var tRows = $('tbody tr');

    for (var i = 0; i < tRows.length; i++) {
      if($(tRows[i]).find('.read-status').text() == "false"){
        $(tRows[i]).hide();
      } else {
        $(tRows[i]).show();
      }
    }
  });


})
