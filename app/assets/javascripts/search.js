$(document).ready(function() {
  $('#navbar_search_button').on('click',function(event) {
    event.preventDefault();

    var searchValue = $('#navbar_search').val();

    $.getScript('/projects?search=' + searchValue);

  });
});