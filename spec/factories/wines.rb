FactoryBot.define do
    factory :wine do
      name { Faker::Lorem.word }
      harvest { Faker::Lorem.word }
      strain { Faker::Lorem.word }
    end
  end
  