class Country < ActiveRecord::Base
  attr_accessible :erep_country_id
  has_many :market_posts

  def to_s
    erep_country_id
  end
end

