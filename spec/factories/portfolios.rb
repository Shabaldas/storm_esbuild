FactoryBot.define do
  factory :portfolio do
    name { Faker::Commerce.product_name }
    category_name { Faker::Commerce.product_name }
    description { Faker::Company.catch_phrase }

    main_picture do
      {
        io: File.new('./spec/fixtures/files/dummy.png'),
        filename: 'dummy.png'
      }
    end
  end
end
