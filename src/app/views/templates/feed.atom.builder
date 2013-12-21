# From http://stackoverflow.com/questions/3951235/how-do-i-make-an-rss-atom-feed-in-rails-3
atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @templates.each do |item|
    next if item.updated_at.blank?

    feed.entry( item ) do |entry|
      entry.url template_url(item)
      entry.title item.title
      entry.description item.description, :type => 'html'
      entry.image request.protocol + request.host + '/uploads/' + item.filename
      
      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.creator User.find(item.user_id).id
    end
  end
end