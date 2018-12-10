App.messages = App.cable.subscriptions.create('NotificationChannel', {  
  received: function(data) {
    if(data.user_follow.includes(parseInt($('#current_user').text()))){
      $('#notification-course').prepend(data.url)
      $('#count-notification').text( parseInt($('#count-notification').text(), 10) + 1 )
    }
    return;
  },
  connected: function() {},
  disconnected: function() {}
});
