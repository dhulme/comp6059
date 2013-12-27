// CSRF setup
// http://stackoverflow.com/questions/7203304/warning-cant-verify-csrf-token-authenticity-rails
var csrfToken = $('meta[name="csrf-token"]').prop('content');
$.ajaxSetup({headers: {'X-CSRF-Token': csrfToken}});

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

// Extend Date
// http://stackoverflow.com/questions/1643320/get-month-name-from-date-using-javascript
Date.prototype.monthNames = ["January", "February", "March","April", "May", "June","July", "August", "September","October", "November", "December"];

Date.prototype.getMonthName = function() {
  return this.monthNames[this.getMonth()];
};

Date.prototype.getShortMonthName = function () {
  return this.getMonthName().substr(0, 3);
};