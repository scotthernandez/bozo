class AlertMailer < ActionMailer::Base
  default :from => "notifications@10gen.com"

  
  #
  #
  #
  def email_new_thread(thread, subject)
    @thread = thread  # used in alert_mailer view code
    
    subject = subject
    users = User.all

    # process Email Alert requests
    email_users = users.find_all { |u| check_send_email(u) }

    if not email_users.empty?
      email_addresses = email_users.map(&:email).join(', ')
      
      logger.info "\n\n[start] sending alert email to #{email_addresses}"
      mail(:to => email_addresses, :subject => subject)
      logger.info "[end] emails sent!"
    else
      logger.info "No users found to send message to - none qualifies"
    end
  end

  
  #
  #
  #
  def sms_new_thread(thread, subject)
    @thread = thread  # used in alert_mailer view code
    
    subject = subject
    users = User.all

    # now process SMS Alert requests
    sms_users = users.find_all { |u| check_send_sms(u) }

    if not sms_users.empty?
      sms_addresses = sms_users.map(&:sms_address).join(', ')
      
      logger.info "\n\n[start] sending alert sms to #{sms_addresses}"
      mail(:to => sms_addresses, :subject => subject)
      logger.info "[end] SMSes sent!"
    else
      logger.info "No users found to send SMS to - none qualifies"
    end
  end
  
  

  #\\\\\\\\\\\\\\\\\\\\\\\\\\\
  private 
  
  #
  #
  #
  def check_send_email(user)
    if user.email_alert?     # user wants email alerts
      t = Time.zone.now
      on_weekends = (t.wday == 0 or t.wday == 6) ? user.weekend? : true   
      
      if not on_weekends
        return false  
      end
      
      # no time specified means always
      if (user.estime.blank? or user.eetime.blank?)
        return true
      end

      # if time specified; test if current time is in between start and end time
      if (t > user.estime) and (t < user.eetime)
        return true
      end
    end
    
    return false
  end

  
  #
  #
  #
  def check_send_sms(user)
    if user.sms_alert?           # user wants sms alerts
      t = Time.zone.now
      t = Time.zone.now
      on_weekends = (t.wday == 0 or t.wday == 6) ? user.weekend? : true   
      
      if not on_weekends
        return false  
      end

      # no time specified means always
      if (user.sstime.blank? or user.setime.blank?) 
        return true
      end

      # if time specified; test if current time is in between start and end time
      if (t > user.sstime) and (t < user.setime)
        return true
      end
    end
    
    return false
  end
  
end
