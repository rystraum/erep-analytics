class Statistics < ActiveRecord::Base
  belongs_to :country
  belongs_to :merchandise
  attr_accessible :date, :minimum, :country, :merchandise
end

