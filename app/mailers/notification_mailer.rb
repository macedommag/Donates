# app/mailers/notification_mailer.rb
class NotificationMailer < ApplicationMailer
  def new_donation_notification(donation)
    @donation = donation
    mail(to: 'recipient@example.com', subject: 'Nova doação recebida')
  end
end
