class Candlestick < ActiveRecord::Base
  belongs_to :merchandise
  belongs_to :country
  attr_accessible :close, :date, :high, :low, :open, :volume
end
