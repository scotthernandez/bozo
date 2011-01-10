config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
        :address    => "smtp.gmail.com",
        :port       => 587,
        :domain     => '10gen.com',
        :user_name  => "roger",
        :password   => "23amobes",
        :authentication => "plain",
        :enabla_starttls_auto => true}

ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(
  :default => '%m/%d/%Y',
  :date_time12  => "%m/%d %I:%M%p",
  :support  => "%m/%d %H:%M"
)



