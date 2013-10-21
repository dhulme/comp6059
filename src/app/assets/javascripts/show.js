$(function() {
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
      $(this).parent().data('star-total', 'star-number');
    });
  });
  
  // Create review button
  $('#createReviewButton').click(function() {
    console.log($(this).siblings('.stars').data('star-number'))
  })
});