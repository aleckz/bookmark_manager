  FactoryGirl.define do # assumes the 'parent model' of :user is User
    
    factory :user do
      email 'foo@bar.com'
      password 'oranges'
      password_confirmation 'oranges'
    end
  
  end
