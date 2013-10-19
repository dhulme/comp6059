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