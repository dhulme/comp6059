$(function() {
  var structure = [];
  
  // Create structure
  $('.content h2').each(function() {
    var el = $(this);
    
    // Create id
    var id = el.text().replace(/\s+/g, '');
    el.prop('id', id);
    var h2 = {
      id: id,
      title: el.text(),
      children: []
    };
    
    el.parent().find('h3').each(function() {
      var el = $(this);
      var id = el.text().replace(/\s+/g, '');
      el.prop('id', id);
      h2.children.push({
        id: id,
        title: el.text()
      });
    });
    
    structure.push(h2);
  });
  
  // Generate HTML
  var html = '<ul class="contents-list">';
  structure.forEach(function(item) {
    html += '<li><a href="#' + item.id + '">' + item.title + '</a>' +
            '<ul class="contents-list">';
    item.children.forEach(function(item) {
      html += '<li><a href="#' + item.id + '">' + item.title + '</a></li>';
    });
    
    html += '</ul>';
  });
  html += '</ul>';
  
  $('#contents').append(html);
  
  var timeout = null;
  // Play buttons
  $('.play-clip-button').click(function() {
    window.clearTimeout(timeout);
    var self = $(this);
    var video = self.parents('.content').find('video').get(0);
    video.currentTime = self.data('startTimecode');
    video.play();
    var fragmentLength = parseInt(self.data('stopTimecode')) - parseInt(self.data('startTimecode'));
    timeout = window.setTimeout(function() {
      video.pause();
    }, (fragmentLength * 1000) + 1000);
  });
  
  $('.play-video-button').click(function() {
    var self = $(this);
    var video = self.parents('.content').find('video').get(0);
    video.play();
  });
});