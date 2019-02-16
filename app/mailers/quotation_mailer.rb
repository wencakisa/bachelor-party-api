class QuotationMailer < ApplicationMailer
  default from: Rails.application.credentials.gmail[:username]

  def updated_status_notification(quotation)
    @quotation = quotation
    mail to: quotation.user_email, subject: 'Quotation ' + quotation.status
  end
end
