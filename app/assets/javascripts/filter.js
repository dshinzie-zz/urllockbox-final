
$(document).ready(function(){
  $("#search").keyup(function(){

    var rows = $('tbody tr').hide();

    if (this.value.length) {
      var data = t.value.split(" ");

      $.each(data, function (index, value) {
        rows.filter(function(){
          return $(this).text().toLowerCase().indexOf(value.toLowerCase()) > -1;
        }).show();
      });
    } else {
      rows.show();
    }
  })
})
