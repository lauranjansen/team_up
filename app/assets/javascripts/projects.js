$(document).ready(function() {
  $('#search_form').on('input', function(event) {
    event.preventDefault();

    var searchValue = $('#search').val();

    $.getScript('/projects?search=' + searchValue);

  });

  $('#project_role_id').on("change", function(event){
    event.preventDefault();

    var projectFilter = $(this).val();
    
    $.getScript('?project_filter=' + projectFilter);

  });

});

$(document).ready(function() {
    $('.apply').on('click', function(e){
      form = $(e.currentTarget).find('.position_request_form');
      form.submit();
    });

  });

// $(document).ready(function() {
//   $('.accept').on('click', function(e){
//     form = $(e.currentTarget).find('.position-update-form');
//     form.submit();
//   });
// });

