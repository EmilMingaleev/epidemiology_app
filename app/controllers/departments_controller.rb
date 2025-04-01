class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @departments = Department.all
  end

  def show; end

  def new
    authorize! Department
    @department = Department.new
  end

  def create
    authorize! Department
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department, notice: "Department was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! @department
  end

  def update
    authorize! @department
    if @department.update(department_params)
      redirect_to @department, notice: "Department was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! @department
    @department.destroy
    redirect_to departments_path, notice: "Department was successfully deleted."
  end

  private

  def set_department
    @department = Department.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :description)
  end
end
