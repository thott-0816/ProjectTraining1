class PayinMailerPreview < ActionMailer::Preview
  def payin_mail_preview
    PayinMailer.payin_email User.first, "ABC123"
  end
end
