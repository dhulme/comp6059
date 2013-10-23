$(function() {
  var csrfToken = $("meta[name='csrf-token']").attr("content");
$.ajaxSetup({
  headers: {
    'X-CSRF-Token': csrfToken
  }
});
  
  // Download button
  $('#downloadButton').click(function(){
    $.get('/download', {
      id: id
    }, function() {
      numDownloads++;
      $('#numDownloadsSpan').html(getDownloadsText(numDownloads));
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
    $.post('/reviews', {
      review: {
        rating: starTotal,
      comment: 'my comment',
      template_id: id
      }
      
    }, function() {
      console.log('done')
    });
  });
});