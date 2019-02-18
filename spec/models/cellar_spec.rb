# Test suite for the Cellar model
require 'rails_helper'

RSpec.describe Cellar, type: :model do
  it { should have_many(:wines).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:location) }
end
