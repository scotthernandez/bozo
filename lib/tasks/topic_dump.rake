namespace :topic_dump do
  
  desc "Convert the topic_dump and populate the Bozo db"
  task :import => :environment do
    puts "[start] importing ..."
    
    db = Mongo::Connection.new.db("mongo_dump")
    topics = db['topics']
    open_status = Status.find_by_name("Open")
    
    topics.find().each do |topic|
      root = topic["root"]
      subject = root["subject"]

      if subject.starts_with?("[mongodb-user] ")
        subject = subject[15, subject.size]
        link_time = root["date"]

        a = Article.where(:subject => subject, :link_time => link_time.utc).first
        
        if a.nil? # ignore if article already exists
          article = Article.new
          
          replies = topic["refs"] || []
          responses = topic["responses"] || []
          topic_author = root["from"]
          topic_author = topic_author[0, topic_author.index("<") || topic_author.size] # strip out email part
          
          authors = responses.collect {|r| r["from"]}
          authors << root["from"]
          authors.uniq!
  
          article.link_time = link_time
          article.author = topic_author
          article.status = open_status
          article.status_name = open_status.name
          article.subject = subject
          article.replies = (replies && replies.size) || 0
          article.authors = authors.size
          
          puts "[saving] #{subject[0,40]} ..." 
          article.save
        else
          puts "[skipping] #{subject[0,40]} ..."
        end
      end
    end
    
    puts "[end] importing ..."
  end
end
