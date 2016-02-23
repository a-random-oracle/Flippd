function secondsToTimeLink(seconds) {
  var currentTime = new Date(null);
  currentTime.setSeconds(seconds);
  if (currentTime.getHours() > 0) {
  	return '@' + currentTime.toISOString().substr(11, 8);
  } else {
  	return '@' + currentTime.toISOString().substr(14, 5);
  }
}

function timeLinkToSeconds(timeLink) {
  var timeString = timeLink.substr(1);
  var time = new Date(null);

  if (timeString.length == 4 || timeString.length == 5) {
    var minuteLength = (timeString.length == 4 ? 1 : 2);
    time.setMinutes(timeString.substr(0, minuteLength));
    time.setSeconds(timeString.substr(minuteLength + 1, 2));
  } else if (timeString.length == 7 || timeString.length == 8) {
    var hourLength = (timeString.length == 7 ? 1 : 2);
    time.setHours(timeString.substr(0, hourLength));
    time.setMinutes(timeString.substr(hourLength + 1, 2));
    time.setSeconds(timeString.substr(hourLength + 4, 2));
  }

  return time.getTime() / 1000;
}



function expandCommentTextareas(textareas) {
  textareas.each(function(index, item) {
    $(this).height(Math.max(item.scrollHeight, 55));
  });
}

$(function() {
  expandCommentTextareas($('.comment-textarea'));
});

$(function() {
  $('.nested-comments-link').click(function() {
  	var newText = ($(this).text() == 'show' ? 'hide' : 'show');
  	$(this).text(newText);
    var nestedCommentsSections = $(this).siblings('.nested-comments');
    nestedCommentsSections.toggle();
    expandCommentTextareas(nestedCommentsSections.find('.comment-textarea'));
  });
});

$(function() {
  $('.time-link').click(function() {
  	setVideoTime(timeLinkToSeconds($(this).text()));
    $('html, body').animate({
        scrollTop: $("#player").offset().top - 60
    }, 500);
    return false;
  });
});

$(function() {
  $('.add-time').click(function() {
    var textArea = $(this).parent().parent().find('.new-comment-textarea');
    var currentText = textArea.val();
    var currentPosition = textArea.prop('selectionStart');
    var textBefore = currentText.substring(0, currentPosition);
    var textAfter = currentText.substring(currentPosition, currentText.length);
    textArea.val(textBefore + secondsToTimeLink(getVideoTime()) + textAfter);
    return false;
  });
});

