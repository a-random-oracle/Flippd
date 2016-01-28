$(function() {
  if ($('*[data-flippd-phase]').length) {
    var phase = $('*[data-flippd-phase]').data('flippd-phase');
    var currentPhaseNavLink = $('#phase_nav_' + phase);
    currentPhaseNavLink.addClass('active');
  }
});
