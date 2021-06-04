FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    age { rand(121) }
    email { Faker::Internet.unique.email }
  end
  
  trait :infant do
    age { rand(6) }
  end

  trait :children do
    age { rand(6..19) }
  end

  trait :adult do
    age { rand(20..64) }
  end

  trait :senior do
    age { rand(65..120) }
  end
end
