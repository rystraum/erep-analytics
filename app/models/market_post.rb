class MarketPost < ActiveRecord::Base
  attr_accessible :country, :merchandise, :price, :provider, :stock
  belongs_to :country
  belongs_to :merchandise
  belongs_to :item
end

