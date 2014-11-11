class StudentsController < ApplicationController

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params)
    if @student.save
      redirect_to students_path, flash: {success: "Student created"}
    else
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  def enroll
    @student = Student.find(params[:id])
  end

  def create_enrollment

    @student = Student.find(params[:student_id])
    # new_course_ids = params[:course_ids].map(&:to_i)

    existing_course_ids = @student.enrollments.pluck(:course_id)
    new_course_ids = params[:course_ids]

      if params[:course_ids].present?

      # BETTER REFACTOR
      # for id in new_course_ids - existing_course_ids
      #   @student.enrollments.create(course_id: id)
      # end
      # @student.enrollments.where(course_id: (existing_course_ids - new_course_ids)).destroy_all

        for course_id in existing_course_ids
          if !new_course_ids.include? course_id
            @student.enrollments.where(course_id: course_id).destroy_all
          end
        end

        for course_id in new_course_ids
          if !existing_course_ids.include? course_id
              @student.enrollments.create(course_id: course_id)
          end
        end
      end
    if @student.save
      redirect_to students_path, notice: "Enrollment saved"
    else
      render :enroll
    end
  end

  def update
    @student = Student.find(params[:id])
    @student.update_attributes(student_params)
    if @student.save
      flash[:success] = "Successfully updated"
      redirect_to students_path
    else
      render :edit
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_path
  end

  private
  def student_params
    params.require(:student).permit(:name)
  end
end
