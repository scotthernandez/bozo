namespace :scrape do
  desc "Scrape the mongodb_user page for new threads"
  task :mongodb_user => :environment do

    # get and preproces the google page. Using curl and grep gets around parsing a more complex page that
    # most libraries tested barf on. 
    snippet = `curl -s http://groups.google.com/group/mongodb-user | grep -A 14 \\"modtxtidt-20`
    doc = Nokogiri::HTML(snippet)


    # helper to extract the time out of the link
    def getLinkTime(t)
       begin
         tt = Time.zone.parse(t).to_s
         return tt[0, tt.length-4]  #delete the 'UTC' trailer
       rescue Exception => e
         puts "error in getLinkTime"
         puts e.message
         puts e.backtrace.inspect
       end
    end


    def email(thread, subject)

    end

    def sms(thread, subject)

    end



    # user, time, author and replies 
    linkUser = Hash.new
    linkTime = Hash.new
    linkAuthors = Hash.new
    linkReplies = Hash.new
    doc.xpath("//td/span[2]").each_with_index { |a, i|
        a.inner_html.split("-").each_with_index { |x, ii|
          x.strip!
          case ii
            when 0
               linkUser[i]=x[3, 100]
            when 1
               linkTime[i]=getLinkTime(x)
            when 2
               linkAuthors[i]=x.to_i
            when 3
               linkReplies[i]=x.to_i
          end
          print "#{i}: #{x}\n"
        }
    }

    linkUrl = Hash.new
    linkId = Hash.new
    linkText = Hash.new
    doc.xpath("//a").each_with_index { |link, i|
        linkText[i]=link.inner_html
        linkUrl[i]=link['href']
        linkId[i]=linkUrl[i][22,50]
        print ">> #{i}:  #{linkUrl[i]}\n"
        print ">> #{i}:  #{linkText[i]}\n"
        print ">> #{i}:  #{linkId[i]}\n"
    }

    (0..(linkId.length-1)).each { |i|


    doc = { "thread" => linkId[i],
            "url"       => linkUrl[i],
            "subject"   => linkText[i],
            "author"    => linkUser[i],
            "time"      => linkTime[i],
            "replies"   => linkReplies[i],
            "authors"   => linkAuthors[i] }


    res = Article.find(:first, :conditions => "thread = '#{linkId[i]}'")
  
    # article  already in database

    if (not res.nil?)
      begin
        puts "Article already in collection #{i} #{linkId[i]}  #{linkTime[i]}\n"
        puts "(#{res.authors}):#{linkAuthors[i]} (#{res.link_time}):#{linkTime[i]} (#{res.replies}):#{linkReplies}"
        res.authors    = linkAuthors[i].to_i
        res.link_time = linkTime[i]
        res.replies   = linkReplies[i].to_i
        res.save
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end

      puts "Calling Alertmailer"

      begin
        AlertMailer.new_thread(res.thread, res.subject).deliver
      rescue Exception => e
        puts "Alert : "
        puts e.message
      end 

    else
      s = Status.find_by_name("Open")

      g = Article.new
      g.thread = linkId[i]
      g.url       = linkUrl[i]
      g.subject   = linkText[i]
      g.author    = linkUser[i]
      g.link_time = linkTime[i]
      g.replies   = linkReplies[i]
      g.authors   = linkAuthors[i]
      g.user = User.find_by_id(1)
      g.status = s
      g.category = Category.first
      g.created_at = Time.now
  
      g.save
    
      puts "Calling Alertmailer"

      begin
        AlertMailer.new_thread(g.thread, g.subject).deliver
      rescue Exception => e
        puts "Alert : "
        puts e.message
      end 
    end

  }

  end
end
