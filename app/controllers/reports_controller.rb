class ReportsController < ApplicationController
  before_action :set_report, only: %i[show]

  def index
    @reports = Report.all
  end

  def show; end

  def edit
  end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)

    if @report.save
      redirect_to report_url(@report), notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
