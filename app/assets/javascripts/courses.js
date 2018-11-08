$(document).ready(function() {
  $('[id^=detail-]').hide();
  $('.toggle').click(function() {
    $input = $(this);
    $target = $('#'+$input.attr('data-toggle'));
    $target.slideToggle();
  });

  $('body').on('click', '#lesson-show', function() {
    var url = $(this).data('url');
    play_close_video(true, url);
  });

  $('#myModal').on('hidden.bs.modal', function () {
    play_close_video(false);
  });
});

function play_close_video(status, url=""){
  if(!status){
    $('video')[0].pause();    
  }
  $('video')[0].src = url;
}
