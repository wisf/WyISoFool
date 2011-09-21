ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "pochemu-ya-takaya-dura.ru",
  :user_name            => "SmitBSU",
  :password             => "RDX5KbPnch",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
