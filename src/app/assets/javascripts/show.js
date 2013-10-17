$(function() {
  // Setup number downloads
  var numDownloadsSpan = $('#numDownloadsSpan');
  if (numDownloads > 1) {
    numDownloadsSpan.html(numDownloads + ' downloads');
  } else {
    if (numDownloads === 1) {
      numDownloadsSpan.html('1 download');
    } else {
      numDownloadsSpan.html('No downloads');
    }
  }
  
  // Download button
  $('#downloadButton').click(function(){
    $.get('/download', {
      id: id
    }, function() {
      numDownloads++;
      if (numDownloads > 1) {
        numDownloadsSpan.html(numDownloads + ' downloads');
      } else {
        numDownloadsSpan.html('1 download');
      }
    });
  });
});