$(document).ready(function() {
  $('body').on('click', '#lesson-show', function() {
    var url = $(this).data('url');
    console.log($(this).data('url'));
    play_close_video(true, url);
  });

  $('#myModal').on('hidden.bs.modal', function () {
    play_close_video(false);
  });

  $('[id^=detail-]').hide();
  $('.toggle').click(function() {
    $input = $(this);
    $target = $('#'+$input.attr('data-toggle'));
    $target.slideToggle();
  });

  $('body').on('click', '.btn-edit-cmt', function() {
    $('.edit-cmt').addClass('hidden');
    $('.message-save-cmt').addClass('hidden');
    $('.show-cmt').removeClass('hidden');
    $('.btn-edit-cmt').removeClass('hidden');

    var oldCmt, newCmt, showCmt, editCmt, btnCmt, messageSave;
    showCmt = $(this).prev('.show-cmt');
    editCmt = $(this).next('.edit-cmt');
    btnCmt = $(this);
    messageSave = editCmt.next('.message-save-cmt');
    oldCmt = showCmt.text();

    editCmt.val(oldCmt);
    btnCmt.addClass('hidden');
    showCmt.addClass('hidden');
    editCmt.removeClass('hidden');
    messageSave.removeClass('hidden');

    editCmt.keydown(function(event) {
      var keycode = event.keyCode ? event.keyCode : event.which;
      newCmt = $(this).val();

      if(keycode == '27') {
        hide_show_edit_cmt(btnCmt, editCmt, messageSave, showCmt);
      }
      
      if(keycode == '13' && !event.shiftKey) {
        if(newCmt == '') {
          alert('Erorr, your comment can not be empty');
          hide_show_edit_cmt(btnCmt, editCmt, messageSave, showCmt);
        } else if(oldCmt == newCmt) {
          hide_show_edit_cmt(btnCmt, editCmt, messageSave, showCmt);
        } else {
          $.ajax({
            url: btnCmt.attr('data-url'),
            type: 'PUT',
            data: {content: newCmt},
            dataType: 'json'
          }).done(function() {
            showCmt.text(newCmt);
          }).fail(function() {
            alert('Erorr, please try again!');
          });
          hide_show_edit_cmt(btnCmt, editCmt, messageSave, showCmt);
        }
      }
    });
  });
});

function hide_show_edit_cmt(btnCmt, editCmt, messageSave, showCmt) {
  btnCmt.removeClass('hidden');
  showCmt.removeClass('hidden');
  messageSave.addClass('hidden');
  editCmt.addClass('hidden');
}

function play_close_video(status, url=""){
  if(!status){
    $('video')[0].pause();
  }
  $('video')[0].src = url;
}

function send_ajax(method, url, data){
  $.ajax({
    type: method,
    url: url,
    dataType: 'json',
    data: data,
    success: function(data){
    },
    error: function (error){
      alert(error);
    }
  });
}

function change_rate(rating) {
  var totalStart=0, totalQuantityRating, startAverage, percent, totalStar;
  totalQuantityRating = parseFloat($('#total-quantity-rating').text()) + 1;
  $(`#quantity-${rating}-start`).text(parseFloat($(`#quantity-${rating}-start`).text()) + 1);
  $('#total-quantity-rating').text(totalQuantityRating);
  
  $('.process-rating').each(function(index){
    totalStart += parseInt($(this).text()) * Math.abs((index - 5));
  });
  
  startAverage = (totalStart/totalQuantityRating).toFixed(1);
  $('#rating-average').text(startAverage);

  for (let i = 1; i <= 5; i++) {
    totalStar = parseInt($(`#quantity-${i}-start`).text());
    percent = parseFloat((totalStar/totalQuantityRating)*100);
    $(`#progress-percent-${i}`).css('width', `${percent}%`);
    $(`#number-percent-${i}`).text(percent.toFixed(1));

    $(`[data-value="${i}"]`).removeClass('half uncheck');
    if(i <= startAverage){
    } else if (i > Math.ceil(startAverage)) {
      $(`[data-value="${i}"]`).addClass('uncheck');
    } else {
      $(`[data-value="${i}"]`).addClass('half');
    }
  }
}
