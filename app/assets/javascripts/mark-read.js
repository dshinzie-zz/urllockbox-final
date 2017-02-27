var $newLinkTitle, $newLinkUrl;

function updateLink(self){
  self.parents('tr').children('td.read-status').text("true")
}

$(document).ready(function(){
  $('#links-list').on('click', 'button.mark-read', function(){
    var $this = $(this);
    var linkId = $this.parents('tr').attr('id')

    $.ajax({
      url: '/api/v1/links/' + linkId,
      method: 'PATCH',
      data: {read: true}
    }).done(updateLink($this));
  })
})
