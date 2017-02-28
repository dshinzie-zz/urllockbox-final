var $newLinkTitle, $newLinkUrl;

function updateLink(self, newStatus){
  toggleText(self)
  self.parents('tr').children('td.read-status').text(newStatus)
}

function toggleText(self){
  textValue = self.text();
  self.text(textValue == "Mark as Read" ? "Mark as Unread" : "Mark as Read");
}

$(document).ready(function(){
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
