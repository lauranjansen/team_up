$(document).ready(function() {
	
  $('#users_search_form').on('input', function(event) {
    event.preventDefault();

    var searchValue2 = $('#search').val();

    $.getScript('/users?search=' + searchValue2);
  });
});