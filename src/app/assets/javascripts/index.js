$(function() {
  var categoryButtons = $('li.category');
  var categoryPanes = $('div.category');
  
  categoryButtons.click(function() {
    categoryButtons.removeClass('active');
    $(this).addClass('active');
    
    var id = $(this).data('category-id');
    categoryPanes.addClass('hidden');
    categoryPanes.filter('[data-category-id="' + id + '"]').removeClass('hidden');
  });
  
  // Highlight first category with content
  var firstPaneWithContent = null;
  categoryPanes.each(function() {
    if ($(this).find('.media').length > 0) {
      firstPaneWithContent = $(this);
      return false;
    }
  });
  
  // If none had content, show the first one
  if (!firstPaneWithContent) {
    categoryButtons.first().addClass('active');
    categoryPanes.first().removeClass('hidden');
  } else {
    categoryButtons.filter('[data-category-id="' + firstPaneWithContent.data('categoryId') + '"]').addClass('active');

    // Show matching pane
    categoryPanes.filter('[data-category-id="' + firstPaneWithContent.data('categoryId') + '"]').removeClass('hidden');
  }
  
  // Search event
  $('#searchInput').keypress(function(e) {
    if (e.which === 13) {
      search($(this).val());
      $(this).val('');
    };
  });
});

function search(term) {
  $.getJSON('/search', {
    term: term
  }, function(templates) {
    // Add templates to search results div
    var html = '';
    templates.forEach(function(template) {
      html += generateMediaHTML(template);
    });
    
    $('#searchResults').html(html);
    $('#resultsForSpan').html(term);
    
    $('div.category').addClass('hidden');
    $('#searchResultsDiv').removeClass('hidden');
  });
}

function generateMediaHTML(template) {
  return '<div class="media">'
    + '<a class="pull-left" href="/templates/' + template.id + '">'
    + '<img alt="' + template.title + '" class="media-object" src="/uploads/' + template.filename + '" width="100">'
    + '</a><div class="media-body"><a href="/templates/' + template.id + '">'
    + '<h4 class="media-heading">' + template.title + '</h4></a>'
    + '<p>' + template.description + '<br><span class="gray">' + template.created_at + '</span></p></div></div>';
}