class BugsController < ApplicationController
  before_action :current_user
  before_action :set_bug, except: %i[index new create]

  def index
    # @bug = Bug.find(params[:id])

    if @current_user.manager?
      @bugs = Bug.all
    elsif @current_user.qa?
      @bugs = Bug.where(user_id: @current_user.id)
    elsif @current_user.developer?
      @bugs = Bug.where(assigned_to: @current_user.id)
    end
  end

  def create
    @bug = Bug.new(bug_params)

    if @bug.save
      # redirect_to @bug
      render "welcome"
    else
      render "new"
    end
  end

  def show
    @comments = @bug.comments
    # @comments = Bug.find(params[:id])
    # can? :update, @comments
  end

  def new
    if @current_user.manager?
      @bug = Bug.new
      @users = User.where(role: [2, 3]) #) && User.where(role: 2)
    elsif @current_user.qa?
      @bug = Bug.new
      @users = User.where(role: 3)
    else
      redirect_to @current_user
    end
  end

  def edit
    if @current_user.manager?
      @users = User.where(role: [2, 3])
    elsif @current_user.qa?
      @users = User.where(role: 3)
    else
      @users = []
    end
  end

  def update
    if @bug.update(bug_params)
      redirect_to @bug
    else
      render "edit"
    end
  end

  def delete
  end

  private

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(
      :title,
      :description,
      :priority,
      :assigned_to,
      :estimated_days,
      :status,
      :user_id
    )
  end
end
