$(document).ready(function() {
  $('#navbar_search_form').submit(function(event) {
    event.preventDefault();

    var searchValue = $('#navbar_search').val();

    $.getScript('/projects?search=' + searchValue);

  });
});