require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
    def sample_mail_preview
    UserMailer.sample_email(Author.first)
  end
end
