module PostEntity
  class Short < Grape::Entity
    expose :title
    expose :body
  end

  class Full < Short
    expose :created_at
    expose :updated_at
  end
end