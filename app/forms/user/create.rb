class User::Create
  ATTRIBUTES = %i[email password first_name last_name birthday]

  include User::Base
end
