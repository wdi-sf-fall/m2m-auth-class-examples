class CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def show
    @course = Course.find(params[:id])
  end

  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.create(course_params)
    if @course.save
      flash[:success] = "Successfully created"
      redirect_to courses_path
    else
      render :new
    end
  end

  def update
    @course = Course.find(params[:id])
    @course.update_attributes(course_params)
    if @course.save
      flash[:success] = "Successfully updated"
      redirect_to courses_path
    else
      render :edit
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.enrollments.destroy_all
    @course.destroy
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit(:name)
  end
end
