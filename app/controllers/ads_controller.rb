class AdsController < ApplicationController
  before_action :logged_in_user, only: [:update, :create, :destroy]
  before_action :correct_user,   only: [:destroy, :update]
  before_action :admin_user, only: [:index]

  def index
    @ads = Ad.where(status: :moderating).paginate(page: params[:page])
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.build(ad_params)
    @ad.status = :draft
    if @ad.save
      flash[:success] = "Ad created!"
      redirect_to request.referrer || root_url
    else
      puts @ad.errors.full_messages
      render request.referrer || root_url
    end
  end

  def destroy
    @id = @ad.id.dup
    @ad.destroy
    @count = current_user.ads.count
    respond_to do |format|
      format.js
    end
  end

  def show
    @ad = Ad.find(params[:id])
    @user = @ad.user
    @tags = Tag.all
  end

  def update
    puts params
    @ad = Ad.find(params[:id])
    @ad.update(ad_params)
    respond_to do |format|
      format.js
    end
  end

  def update_tags
    puts params
    @ad = Ad.find(params[:ad_id])
    tags_to_update = []
    if params.has_key?(:ad)
      params[:ad][:tags].each do |tag|
        new_tag = Tag.find_by(name: tag)
        tags_to_update<<new_tag
      end
    end
    @ad.tags = tags_to_update
    respond_to do |format|
      format.js
    end
  end

  def update_status
    puts params
    @ad = Ad.find(params[:ad_id])
    @ad.update(ad_params)
    respond_to do |format|
      format.js
    end
  end


  private

    def ad_params
      params.require(:ad).permit(:name, :status, :content, :reason, pictures: [], tags: [])
    end

    def correct_user
      @ad = current_user.ads.find_by(id: params[:id])
      redirect_to root_url if @ad.nil? && !current_user.admin?
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
