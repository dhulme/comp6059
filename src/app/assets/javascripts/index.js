$(function() {
  var categoryButtons = $('li.categories');
  var categoryPanes = $('div.categories');
  
  // Highlight first category
  
  categoryButtons.first().addClass('active');
  
  // Show matching pane
  categoryPanes.first().removeClass('hidden');
  
  categoryButtons.click(function() {
    categoryButtons.removeClass('active');
    $(this).addClass('active');
    
    var id = $(this).data('category-id');
    categoryPanes.addClass('hidden');
    categoryPanes.filter('[data-category-id="' + id + '"]').removeClass('hidden');
  });
});