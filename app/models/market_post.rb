class MarketPost < ActiveRecord::Base
  attr_accessible :country, :merchandise, :price, :provider, :stock
  belongs_to :country
  belongs_to :merchandise
  belongs_to :item

  delegate :record_date, to: :item

  def as_json(opts = {})
    super.merge({ record_date: self.record_date, country: self.country.to_s, item: self.merchandise.to_s })
  end
end

