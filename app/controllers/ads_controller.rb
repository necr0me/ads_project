class AdsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @ad = Ad.new
  end

  def create
    @ad = current_user.ads.build(ad_params)
    if @ad.save
      flash[:success] = "Ad created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @ad.destroy
    flash[:success] = "Ad deleted"
    redirect_to request.referrer || root_url
  end

  private

    def ad_params
      params.require(:ad).permit(:name, :content, pictures: [])
    end

    def correct_user
      @ad = current_user.ads.find_by(id: params[:id])
      redirect_to root_url if @ad.nil?
    end

end
