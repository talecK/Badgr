class FeedItemsController < ApplicationController

  def remove
    #@group = Group.find(params[:source_id])
    @feed_item = FeedItem.find(params[:id])
    @feed = Feed.find(params[:feed_id])
    unless @feed_item.nil? || @feed.nil?
      @feed.feed_items -= [@feed_item]
      @feed.save
    else
      redirect_to root_path
    end
  end
end

