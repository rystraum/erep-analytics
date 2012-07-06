class Merchandise < ActiveRecord::Base
  attr_accessible :erep_item_code, :quality
  has_many :market_posts

  def item
    case erep_item_code
    when 1
      "Food"
    when 2
      "Weapons"
    else
      "Misc"
    end
  end

  def to_s
    "#{item}, Q#{quality}"
  end
end

