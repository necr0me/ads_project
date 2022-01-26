class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @ad = current_user.ads.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
  end

  def contact
  end
end
