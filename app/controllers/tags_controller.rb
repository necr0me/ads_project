class TagsController < ApplicationController
  before_action :admin_user ,only: [:create, :destroy, :index]


  def create
    puts params
    @tag = Tag.new(tag_params)
    @tag.save
    respond_to do |format|
      format.js
    end
  end

  def index
    @tags = Tag.all.paginate(page: params[:page], per_page: 10)
  end

  def destroy
    puts params
    @tag = Tag.find(params[:id])
    @id = params[:id]
    @tag.destroy
    respond_to do |format|
      format.js
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
