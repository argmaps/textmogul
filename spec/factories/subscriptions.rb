# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    stripe_id "MyString"
    plan nil
    subscriber nil
    last_four 1
    card_type "MyString"
    expiration_month 1
    expiration_year 1
  end
end
