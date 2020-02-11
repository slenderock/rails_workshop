module UserEntity
  class Short < Grape::Entity
    expose :first_name
    expose :last_name
    expose :birthday,
      if: ->(record) { record.birthday.past? }
  end

  class Full < Short
    expose :email
    expose :posts, with: ::PostEntity::Short
  end
end