function addBorder(self){
  self.parents('tr').find(".link-title").attr("contenteditable", "true").addClass("border");
  self.parents('tr').find(".link-url").attr("contenteditable", "true").addClass("border");
  self.parents('tr').find(".read-status").attr("contenteditable", "true").addClass("border");
}

function removeBorder(self){
  self.parents('tr').find(".link-title").attr("contenteditable", "false").removeClass("border");
  self.parents('tr').find(".link-url").attr("contenteditable", "false").removeClass("border");
  self.parents('tr').find(".read-status").attr("contenteditable", "false").removeClass("border")
}

function updateEditLink(self, newTitle, newUrl, newStatus){
  self.parents('tr').find(".link-title").text(newTitle);
  self.parents('tr').find(".link-url").text(newUrl);
  self.parents('tr').find(".read-status").text(newStatus);

  removeBorder(self);
  toggleText(self);
}

function toggleText(self){
  textValue = self.text();
  self.text(textValue == "Edit" ? "Save" : "Edit");
}

function submitEdit(event, oldValues){
  var $this = $(event.target);
  var linkId = $this.parents('tr').attr('id')
  newValues = getValues($this);

  $.ajax({
    url: "./api/v1/links/" + linkId,
    method: "PUT",
    data: { id: linkId, title: newValues.title, url: newValues.url, read: newValues.status }
  }).done(function(){
    console.log("Update Successful")
    updateEditLink($this, newValues.title, newValues.url, newValues.status);
  }).fail(function(error){
    updateEditLink($this, oldValues.title, oldValues.url, oldValues.status);
    $("#notice").html(JSON.parse(error.responseText).join(","));
  });
}

function getValues(self){
  var currentTitle = self.parents('tr').find('.link-title').text();
  var currentUrl = self.parents('tr').find('.link-url').text();
  var currentStatus = self.parents('tr').find('.link-status').text();

  return {
    title: currentTitle,
    url: currentUrl,
    status: currentStatus
  }
}

$(document).ready(function(){
  $("tbody").on("click", ".edit", function(event){
    $this = $(this);
    toggleText($this)
    addBorder($this);
    oldValues = getValues($this);
    var submitButton = $this.parents('tr').find('td:last')

    submitButton.on("click", function(event){
      if($this.text() == "Save"){
        submitEdit(event, oldValues);
      };
    });
  });

});
