$(document).ready(function() {
  $('#import_form').submit(function(event) {
    event.preventDefault();

    var linkedin_url = $('#linkedin_url').val();

    console.log(linkedin_url);

    $.getScript('/users/import?linkedin_url=' + linkedin_url);

  });
});