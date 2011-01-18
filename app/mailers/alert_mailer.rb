class AlertMailer < ActionMailer::Base
  default :from => "notifications@10gen.com"

  def new_thread(thread, subject)
     @thread = thread
     @subject = subject

     to = User.all

     @to = to.find_all {|u| send_email(u)}

     if !(@to.empty?)
       logger.info  "Sending alert emails"
       logger.info  "#{@to.map(&:email).join(', ')}"

       mail(:to => @to.map(&:email).join(", "), :subject => @subject)
       logger.info "sending email to #{@to.map(&:email).join(", ")}"
     else
       logger.info "No users found to send message to - none qualifies"
     end
          

  end


  def send_email(user)
    if user.gmail then    #user wants email
      t = Time.now.strftime("%H:%M")

      # no time specified means always
      if (user.estime.blank? or user.eetime.blank?) then
        return true
      end

      # if time specified; test if current time is in between start and endtime
      if (t > user.estime) and (t < user.eetime)
        return true
      end

    end
    return false
  end

  def send sms

  end
  
end
