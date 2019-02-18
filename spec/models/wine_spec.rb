# Test suite for the Wine model
require 'rails_helper'

RSpec.describe Wine, type: :model do
  it { should belong_to(:cellar) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:harvest) }
  it { should validate_presence_of(:strain) }
end
