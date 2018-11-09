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
});

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
