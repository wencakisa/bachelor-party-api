class QuotationMailer < ApplicationMailer
  def notify_customer_for_status_update(quotation)
    @quotation = quotation
    mail to: quotation.user_email, subject: 'Quotation ' + quotation.status
  end
end
