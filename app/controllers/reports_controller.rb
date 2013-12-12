class ReportsController < ApplicationController
  def create
    redirect_to home_path unless request.xhr?
    @report = Report.create(report_params.merge(ip: request.remote_ip))
    @report.save
    DefaultMailer.report_email(@report, current_user||nil).deliver
    render inline: ''
  end

private

  def report_params
    params.require(:report).permit(:message, :list_id)
  end
end
