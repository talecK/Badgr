class FeedItemsController < ApplicationController

  def remove
    @group = Group.find(params[:source_id])
    unless @group.nil?
      @feed_item = @group.feed.feed_items.find( params[:id] )
      @group.feed.feed_items -= [@feed_item]
      @group.save
    end
  end
end

