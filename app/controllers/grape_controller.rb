class GrapeController < Grape::API
  mount ::Api::AuthController

  add_swagger_documentation
end