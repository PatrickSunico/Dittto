// Validations for Dropzone
var newAttachment = $("#new_attachment");
Dropzone.options.newAttachment = { // The camelized version of the ID of the form element
autoDiscover: false,
// The configuration we've talked about above
autoProcessQueue: false,
parallelUploads: 100,
maxFilesize: 2,
paramName: "attachment[image]",
addRemoveLinks: true,
dictDefaultMessage: "<h2> Click anywhere or Drag and Drop Files here to Upload</h2> <p>Max File Upload 3 <br> Upload Limit is 1mb</p>",
dictFileTooBig: "File too Big, Size limit is 1mb",
acceptedFiles: ".jpeg,.jpg,.png,.gif",
maxFiles: 3,

  // The setting up of the dropzone
  init: function() {
    var newAttachment = this;
    // First change the button to actually tell Dropzone to process the queue.
    newAttachment.element.querySelector("input[type=submit]").addEventListener("click", function(e) {
        e.preventDefault();
        e.stopPropagation();
        newAttachment.processQueue();
    });


      // filter out rejected files
      this.on("queuecomplete", function(file, response) {
        var self = this;
        if (self.getUploadingFiles().length === 0 && self.getQueuedFiles().length === 0) {
          var rejectedFiles = self.getRejectedFiles();
          // Start if no rejected files dropped
          console.log(rejectedFiles.size);
          if (rejectedFiles.length != 0) {
            // if rejectedFile dropped remove it immediately
              self.removeAllFiles(file);
              // then fire a swal error
              swal({
               title: "Error",
               text: "Images Only",
               type: "error"
             });
          }
          // Max File Size Error Message
          rejectedFiles.forEach(function(index) {
            if (index.size > 2048) {
              self.removeAllFiles(file);
              swal({
                title: "Error",
                text: "Max Filesize Exceed limit 2mb",
                type: "error"
              });
            }
          });

        }
      });

    this.on("success", function(file, responseText) {
      var self = this;
      console.log(responseText.post);
      console.log(file);
      if (self.getUploadingFiles().length === 0 && self.getQueuedFiles().length === 0) {
          var acceptedFiles = self.getAcceptedFiles();
          var rejectedFiles = self.getRejectedFiles();

          if(acceptedFiles.length != 0) {
            swal({
              title: "Success",
              text: "Uploads Successful",
              type: "success",
              confirmationButtonText: "Ok"
            },function() {
                // redirect back to post with it's id
                // .post sent from responseText via attachments_controller create route
                  window.location.href = ("/posts/" + responseText.post)
                // if redirect to show route with corresponding id
            });
          }
        }
    });

  }
}
