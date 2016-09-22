$(document).ready(function() {
  var $inputField;
  $inputField = $('input#post_thumbnail');
  $inputField.change(function() {
    return $('#file-display').val($(this).val().replace(/^.*[\\\/]/, ''));
  });
  return $('button#upload-btn').click(function(e) {
    e.preventDefault();
    e.stopPropagation();
    return $inputField.click();
  });
});
