class User::Update
  ATTRIBUTES = %i[first_name last_name birthday]

  include User::Base
end