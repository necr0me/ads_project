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
    @ad.destroy
    flash[:success] = "Ad deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @ad = Ad.find(params[:id])
    @user = @ad.user
    @tags = Tag.where.not(id: @ad.tags)
  end


  def update
    @ad = Ad.find(params[:id])
    if params[:ad][:tags]
      params[:ad][:tags].each do |tag|
        new_tag = Tag.find_by(name: tag)
        puts tag
        @ad.tags << new_tag
      end
    else
      @ad.update(ad_params)
      redirect_to request.referrer
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
