class Post < ActiveRecord::Base
  attr_accessible :country_id, :item_code, :item_quality, :poster_id, :price, :record_date, :stock
end
