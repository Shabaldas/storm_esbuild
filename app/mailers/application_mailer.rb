# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: '3d.storm.des@gmail.com'
  layout 'mailer'
end
