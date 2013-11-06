$(function() {
  // Extend Date
  // http://stackoverflow.com/questions/1643320/get-month-name-from-date-using-javascript
  Date.prototype.monthNames = [
    "January", "February", "March",
    "April", "May", "June",
    "July", "August", "September",
    "October", "November", "December"
  ];

  Date.prototype.getMonthName = function() {
    return this.monthNames[this.getMonth()];
  };
  Date.prototype.getShortMonthName = function () {
    return this.getMonthName().substr(0, 3);
  };

  
  // Download button
  $('#downloadButton').click(function(){
    $.post('/download', {
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
        comment: $('#commentTextarea').val(),
        template_id: id
      }
    }, function(res) {
      // Hide create section
      $('#addReviewDiv').addClass('hidden');
      
      // Generate stars HTML
      var starsHTML = '<div>';
      for (var i = 0; i < 5; i++) {
        if (i < res.rating) {
          starsHTML += '<span class="glyphicon glyphicon-star"></span>';
        } else {
          starsHTML += '<span class="glyphicon glyphicon-star-empty"></span>';
        }
      }
      starsHTML += '</div>';
      
      // Generate time HTML
      var date = new Date();
      var timeHTML = date.getDate() + ' ' + date.getShortMonthName() + ' '
        + date.getHours() + ':' + date.getMinutes();
      
      // Add review HTML
      var html = '<blockquote><p>' + res.comment + '</p>' + starsHTML
        + '<small>AUTHOR, at ' + timeHTML + '</small></blockquote>';

      $('#reviews').prepend(html);
    });
  });
});