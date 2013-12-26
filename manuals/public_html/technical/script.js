$(function() {
  var structure = [];
  
  // Create structure
  $('h2').each(function() {
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
  var html = '<ul>';
  structure.forEach(function(item) {
    html += '<li><a href="#' + item.id + '">' + item.title + '</a>' +
            '<ul>';
    item.children.forEach(function(item) {
      html += '<li><a href="#' + item.id + '">' + item.title + '</a></li>';
    });
    
    html += '</ul>';
  });
  html += '</ul>';
  
  $('#header').append(html);
});