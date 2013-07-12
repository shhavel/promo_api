module Presenters
  class OptIn < Grape::Entity
    expose :email
    expose :mobile
    expose :first_name
    expose :last_name
    expose :permission_type
    expose :channel
    expose :company_name
    expose :links do |model|
      [
        { rel: :self, href: "/optins/#{model.id}" }
      ]
    end
  end
end
