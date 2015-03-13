$(document).ready(function() {
  $('#search_form').submit(function(event) {
      event.preventDefault();

    var searchValue = $('#search').val();

$.getScript('/projects?search=' + searchValue);

  });
});

$(document).ready(function() {
    $('.card').flip({
      axis: 'y',
      trigger: 'hover',
      reverse: true
    });

    // $('.back').on('click', function(e){
    //   form = $(e.currentTarget).find('.position-form');
    //   form.submit();
    //   });

  });