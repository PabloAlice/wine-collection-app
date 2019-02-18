class Wine < ApplicationRecord
  belongs_to :cellar

  # validation
  validates_presence_of :name, :harvest, :strain
end
