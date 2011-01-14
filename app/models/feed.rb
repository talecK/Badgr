class Feed < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  has_many :feed_items, :through => :feed_subscriptions
  has_many :feed_subscriptions

  # def find_feed_item( values = {} )
   # self.feed_items.to_ary.find { |item| ( item.source == values[:source] ) }
  # end

  # adds a feed item reference, if the feed doesn't already reference it
  def add_feed_item( item )
    unless( self.feed_items.exists?(item.id) )
     return self.feed_subscriptions.create(:feed_item_id => item.id)
    else
     return false
    end
  end

end

