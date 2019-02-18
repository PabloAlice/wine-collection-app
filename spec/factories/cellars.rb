FactoryBot.define do
    factory :cellar do
      name { Faker::Lorem.word }
      location { Faker::Address.full_address }
    end
  end