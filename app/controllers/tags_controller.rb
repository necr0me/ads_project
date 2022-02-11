class TagsController < ApplicationController
  before_action :admin_user ,only: [:new, :create, :destroy]

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:success] = "You have created a new tag."
      redirect_to new_tag_path
    else
      render 'new'
    end
  end


  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
