class City < ActiveRecord::Base
  has_many :restaurants

  validates :id, :presence => true
  validates :name, :presence => true
end
