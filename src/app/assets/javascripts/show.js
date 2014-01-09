$(function() {
  // Download button
  $('#downloadButton').click(function(){
    $.post('/downloads', { templateId: id }, function(increaseCounter) {
      if (increaseCounter) {
        numDownloads++;
        $('#numDownloadsSpan').html(getDownloadsText(numDownloads));
        $('#addReviewButton').prop('disabled', false);
      }
    });
  });
  
  // Add review button
  $('#addReviewButton').click(function() {
    var addReviewDiv = $('#addReviewDiv');
    addReviewDiv.removeClass('hidden');
    $(this).addClass('hidden');
    
    // Generate stars
    for (var i = 0; i < 5; i++) {
      var html = '<span class="star glyphicon glyphicon-star-empty" data-star-number="' + i + '"></span>';
      addReviewDiv.find('.stars').append(html);
    }
    
    $('.star').click(function() {
      var starNumber = $(this).data('star-number');
      $(this).parent().children().each(function(index, star) {
        $(star).removeClass('glyphicon-star');
        $(star).addClass('glyphicon-star-empty');
        
        if (index <= starNumber) {
          $(star).removeClass('glyphicon-star-empty');
          $(star).addClass('glyphicon-star');
        }
      });
      $(this).parent().data('star-total', starNumber + 1);
    });
  });
  
  // Create review button
  $('#createReviewButton').click(function() {
    var starTotal = $(this).siblings('.stars').data('star-total');
    if (!starTotal) return;
    $.post('/reviews', {
      review: { rating: starTotal, comment: $('#commentTextarea').val(), template_id: id }
    }, function(res) {
      // Hide create section
      $('#addReviewDiv').addClass('hidden');
      
      // Generate stars HTML
      var starsHTML = '<div>';
      for (var i = 0; i < 5; i++) {
        starsHTML += (i < res.rating ? '<span class="glyphicon glyphicon-star"></span>' : '<span class="glyphicon glyphicon-star-empty"></span>');
      }
      starsHTML += '</div>';
      
      // Generate time HTML
      var date = new Date();
      var timeHTML = date.getDate() + ' ' + date.getShortMonthName() + ' ' + date.getHours() + ':' + date.getMinutes();
      
      // Add review HTML
      var html = '<blockquote><p>' + res.comment + '</p>' + starsHTML + '<small>You, at ' + timeHTML + '</small></blockquote>';

      $('#reviews').prepend(html);
    });
  });
  
  // Edit button
  $('#editButton').click(function() {
    var templateTitleElement = $('#templateTitle');
    var templateDescriptionElement = $('#templateDescription');
    var editButtonElement = $('#editButton');
    
    if (editButtonElement.text() === 'Edit template') {
      // Edit mode
      // Replace with controls
      templateTitleElement.html('<input type="text" value="' + templateTitleElement.text() + '">');
      templateDescriptionElement.html('<input type="text" value="' + templateDescriptionElement.text() + '">');

      editButtonElement.text('Save template');
    } else {
      // Save mode
      $.ajax({
        url: window.location.pathname,
        method: 'PUT',
        data: { template: {
          title: templateTitleElement.find('input').val(),
          description: templateDescriptionElement.find('input').val()
        }}
      }).done(function(res) {
        templateTitleElement.text(res.title);
        templateDescriptionElement.text(res.description);
        editButtonElement.text('Edit template');
      });
    }
  });
  
  // Delete button
  $('#deleteButton').click(function() {
    bootbox.confirm('Are you sure you want to delete this template?', function(res) {
      if (res) {
        $.ajax({
          url: window.location.pathname,
          method: 'DELETE'
        }).done(function() {
          window.location.pathname = '/templates';
        });
      }
    });
  });
});