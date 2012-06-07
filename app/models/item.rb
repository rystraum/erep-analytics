class Item < ActiveRecord::Base
  attr_accessible :country, :data, :item_quality, :item_type

  before_create :sanitize_fields

  def sanitize_fields
    self.country = self.country.split("/").last.to_i
    self.item_quality = self.item_quality.split("/").last.to_i
    self.item_type = self.item_type.split("/").last.to_i
  end
end

