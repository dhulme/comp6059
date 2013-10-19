$(function() {
  // Download button
  $('#downloadButton').click(function(){
    $.get('/download', {
      id: id
    }, function() {
      numDownloads++;
      $('#numDownloadsSpan').html(getDownloadsText(numDownloads));
    });
  });
});