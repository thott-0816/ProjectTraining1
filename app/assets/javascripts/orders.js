$(document).ready(function() {
  $('.hide-detail').hide();
  $('.order-item').on('click', function() {
    let counter = $(this).data('counter');
    $(`.order-detail-${counter}`).toggle();
    $(`.icon-up-down-${counter}`).toggle();
  });
});
