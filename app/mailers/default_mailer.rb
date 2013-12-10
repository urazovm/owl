class DefaultMailer < ActionMailer::Base
  def report_email(report, user)
    @report = report
    @user = user
    mail(to: 'contact@owl.com', from: 'no-reply@owl.com', subject: "Content reported: #{report.list.title}")
  end
end
