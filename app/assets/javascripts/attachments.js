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
dictDefaultMessage: "<h2>Click anywhere or Drag and Drop Files here to Upload</h2>",
dictFileTooBig: "File too Big, Size limit is 2mb",
acceptedFiles: "image/jpeg,image/png,image/gif",
previewsContainer: "#preview-area",
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

    this.on("addedfile", function(files) {
      var self = this;
      var file_list = self.files
      var rejectedFiles = self.getRejectedFiles();
      var acceptedFiles = self.options.acceptedFiles;
      var uploadMessage = $("div.text-container");
      var removeLink = $('a.dz-remove')


      // file_list[3] = limit of files that is allowed to be dropped
      if (file_list[3] != null){
        // removes the last file in the array
        self.removeFile(self.files[3]);
        swal({
          title: "Error",
          text: "Max File Limit Reached",
          type: "error"
        });
      }
      // Removes files that are greater than 2mb
      file_list.forEach(function(index){
        // 2e+6 in bytes
        if (index.size > 2e+6) {
          self.removeFile(index);
          swal({
            title: "Error",
            text: "Max Filesize Exceed limit 2mb",
            type: "error"
          });
        }
      });

      // Hides Message If there are dropped files in the Dropzone
      // Show Message If there are no dropped files in the dropzone
      file_list.forEach(function(index) {
        console.log(index);
        if(index > 1) {
          uploadMessage.show();
        } else {
          uploadMessage.hide();
        }
        removeLink.on("click", function(e) {
          if (self.getUploadingFiles().length === 0 && self.getQueuedFiles().length === 0) {
            uploadMessage.show();
          }
        });
      });
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
                  window.location.href = ("/posts/" + responseText.post)
                // if redirect to show route with corresponding id
            });
          }
        }
    });
  }
}
