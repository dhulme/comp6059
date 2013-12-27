$(function() {
  $('.edit-category-button').click(function() {
    var editCategoryButton = $(this);
    var parent = editCategoryButton.parent();
    var categoryName = parent.find('.category-name');
    
    // Edit mode
    if (editCategoryButton.hasClass('glyphicon-pencil')) {
      categoryName.html('<input type="text" value="' + categoryName.text() + '">');
      
      editCategoryButton.removeClass('glyphicon-pencil');
      editCategoryButton.addClass('glyphicon-floppy-disk');
      
      return;
    }
    
    // Save mode
    if (editCategoryButton.hasClass('glyphicon-floppy-disk')) {
      $.ajax({ 
        url: '/categories/' + parent.data('categoryId'),
        method: 'PUT',
        data: {
          category: {
            name: categoryName.find('input').val()
          }
        }
      }).done(function(res) {
        categoryName.html(res.name);
        
        editCategoryButton.removeClass('glyphicon-floppy-disk');
        editCategoryButton.addClass('glyphicon-pencil');
      });
    }
  });
});