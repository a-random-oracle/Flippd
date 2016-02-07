function expandCommentTextareas(textareas) {
  textareas.each(function(index, item) {
    $(this).height(item.scrollHeight);
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