class Cellar < ApplicationRecord
  has_many :wines, dependent: :destroy

  # validations
  validates_presence_of :name, :location
end
