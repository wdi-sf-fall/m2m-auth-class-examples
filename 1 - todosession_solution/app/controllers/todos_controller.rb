class TodosController < ApplicationController

  def index
   @todos = session[:todos] ||= []
  end

  def create
    if params[:task] == ""
      redirect_to todos_path, alert: "Not cool...."
    else
      session[:todos].push(params[:task])
      flash[:success]
      redirect_to todos_path, flash: {success: "Created"}
    end
  end

  def destroy_one
    if session[:todos].include? params[:task]
      session[:todos].delete(params[:task])
    end
    redirect_to todos_path, notice: "Destroyed"
  end

  def destroy_all
    session[:todos] = []
    redirect_to todos_path, notice: "All todos have been removed"
  end
end
