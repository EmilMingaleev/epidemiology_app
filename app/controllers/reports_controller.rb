class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department

  def show
    @report = Report.find(params[:id])
  end

  def new
    @report = @department.reports.build
  end

  def create
    @report = @department.reports.build(report_params)
    @report.user = current_user

    if @report.save
      redirect_to @department, notice: "Report was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_department
    @department = Department.find(params[:department_id])
  end

  def report_params
    params.require(:report).permit(:pdf, :uploaded_at, :comments)
  end
end
