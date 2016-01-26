var main  = function() {
  $('.remove-student').hide();
  $('#toggleButton').click(function() {
    $(".remove-student").toggle();

    if ($(this).val() == "Edit Class") {
      $(this).val("Done");
    } else {
    $(this).val("Edit Class");
    }
  });
}


$(document).ready(main);
