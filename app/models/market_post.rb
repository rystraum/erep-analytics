class MarketPost < ActiveRecord::Base
  attr_accessible :country, :merchandise, :price, :provider, :stock
  belongs_to :country
  belongs_to :merchandise
  belongs_to :item

  delegate :record_date, to: :item
end

