# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :translation do
    text_resource_id 1
    language_id 1
    content "MyString"
  end
end
