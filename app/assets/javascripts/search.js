$(document).ready(function() {
  $( ".item-search" ).hover(
    function() {
      $(this).addClass('active');
      $(this).find('.btn-detail').addClass('btn-default');
      $(this).find('.btn-detail').removeClass('btn-primary');
    }, function() {
      $(this).removeClass('active');
      $(this).find('.btn-detail').removeClass('btn-default');
      $(this).find('.btn-detail').addClass('btn-primary');
    }
  );

  if($('#key-search').text() != ""){
    search($('#key-search').text());
  }
});

function search(key_search){
  key_search = key_search.split(' ');
  for(var i = 0; i < key_search.length; i++){
    $('.course-name').each(function(){
      higlight(this, key_search[i]);
    });
    $('.course-description').each(function(){
      higlight(this, key_search[i]);
    });
    $('.user-name').each(function(){
      higlight(this, key_search[i]);
    });
  }
}

function higlight(element, key){
  var src_str = $(element).html();
  var term = key;
  term = term.replace(/(\s+)/,"(<[^>]+>)*$1(<[^>]+>)*");
  var pattern = new RegExp("("+term+")", "gi");

  src_str = src_str.replace(pattern, "<mark>$1</mark>");
  src_str = src_str.replace(/(<mark>[^<>]*)((<[^>]+>)+)([^<>]*<\/mark>)/,"$1</mark>$2<mark>$4");

  $(element).html(src_str);
}
