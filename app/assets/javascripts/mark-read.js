var $newLinkTitle, $newLinkUrl;

function updateLink(self, newStatus){
  toggleText(self)
  toggleStrike(self, newStatus);
  self.parents('tr').children('td.read-status').text(newStatus)
}

function toggleText(self){
  textValue = self.text();
  self.text(textValue == "Mark as Read" ? "Mark as Unread" : "Mark as Read");
}

function toggleStrike(self, newStatus){
  newStatus == "true" ? self.parents('tr').addClass("strike") : self.parents('tr').removeClass("strike");
}

function setButtons(){
  tRows = $('tbody tr');
  for (var i = 0; i < tRows.length; i++) {
    tableRow = $(tRows[i]).find('.read-status').text();
    buttonText = $(tRows[i]).find('.mark-read')

    if(tableRow == "true"){
      buttonText.text("Mark as Unread");
      buttonText.parents('tr').addClass("strike");
      // buttonText.text(tableRow == "true" ? "Mark as Unread" : "Mark as Read");
    } else {
      buttonText.text("Mark as Read");
      buttonText.parents('tr').removeClass("strike");
    }
  }
}

$(document).ready(function(){
  setButtons();

  $('#links-list').on('click', 'button.mark-read', function(){
    var $this = $(this);
    var linkId = $this.parents('tr').attr('id')
    var newStatus;

    readStatus = $this.parents('tr').find('.read-status').text();
    readStatus == "true" ? newStatus = false : newStatus = true;

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: newStatus}
    }).done(updateLink($this, newStatus));
  })
})
