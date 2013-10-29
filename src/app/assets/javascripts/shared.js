// CSRF setup
// http://stackoverflow.com/questions/7203304/warning-cant-verify-csrf-token-authenticity-rails
var csrfToken = $('meta[name="csrf-token"]').prop('content');
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': csrfToken
  }
});

function getDownloadsText(numDownloads) {
  var downloadText;
  if (numDownloads > 1) {
    downloadText = numDownloads + ' downloads';
  } else {
    if (numDownloads === 1) {
      downloadText = '1 download';
    } else {
      downloadText = 'No downloads';
    }
  }
  return downloadText;
}