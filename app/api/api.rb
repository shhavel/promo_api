require_relative 'opt_in_api'

class API < Grape::API
  format :json

  resource :opt_ins do
    mount OptInAPI => '/'
  end
end
