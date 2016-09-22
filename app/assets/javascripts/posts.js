$(document).ready(function() {
  var $inputField;
  $inputField = $('input#post_thumbnail');
  $inputField.change(function() {
    return $('#file-display').val($(this).val().replace(/^.*[\\\/]/, ''));
  });
  return $('#upload-btn').click(function() {
    return $inputField.click();
  });
});
