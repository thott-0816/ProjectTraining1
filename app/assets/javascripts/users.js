$(document).ready(function(){
  $('.form-change-pass').hide();
  $('#change_pass').on('click', function() {
    if (this.checked) {
      $('.form-change-pass').show();
      $('.add-required').prop('required', true);
    } else {
      $('.form-change-pass').hide();
      $('.add-required').prop('required', false);
    }
  });

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        $('#img-prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $('#user_avatar').change(function() {
    let size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Maximum file size is 5MB. Please choose a smaller file.');
    } else {
      $('#img-prev').removeClass('hidden');
      $('.img-avatar').addClass('hidden');
      readURL(this);
    }
  });

  $( ".add_lesson" ).hide();

  $('.add_form').click(function(){
    $('.add_lesson').toggle();
  });
});
