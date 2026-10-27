class UserMailerPreview < ActionMailer::Preview
  def welcome
    UserMailer.welcome(User.first || User.new(email_address: "preview@example.com"))
  end
end