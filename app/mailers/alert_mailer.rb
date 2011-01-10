class AlertMailer < ActionMailer::Base
  default :from => "notifications@10gen.com"

  def new_thread(thread, subject)
     @thread = thread
     @subject = subject

     @to = User.find(:all, :conditions => "email_y = true")

     if !(@to.empty?)
       logger.info  "Sending alert emails"
       logger.info  "#{@to.map(&:email).join(', ')}"

       mail(:to => @to.map(&:email).join(", "), :subject => @subject)
     else
       logger.info "No users found to send message to: email_y = false for everyone"
     end
          

  end
  
end
