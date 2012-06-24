class Merchandise < ActiveRecord::Base
  attr_accessible :erep_item_code, :quality
  has_many :market_posts
end

