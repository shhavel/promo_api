class OptInAPI < Grape::API
  desc "Get all opt-ins."
  get do
    present OptIn.all, with: Presenters::OptIn
  end

  desc "Return an opt-in."
  params do
    requires :id, type: Integer, desc: "Opt-in id."
  end
  get ':id' do
    present OptIn.find(params[:id]), Presenters::OptIn
  end

  desc "Create an opt-in."
  params do
    requires :email, type: String, desc: "E-mail"
    requires :channel, type: String, desc: "Channel"
    requires :company_name, type: String, desc: "Company name"
  end
  post do
    OptIn.create!(params)
  end

  desc "Update an opt-in."
  params do
    requires :id, type: String, desc: "Opt-in ID."
  end
  put ':id' do
    opt_in = OptIn.find(params[:id])
    opt_in.update_attributes(params.clone.tap { |attrs| attrs.delete(:id) })
  end

  desc "Delete an opt-in."
  params do
    requires :id, type: Integer, desc: "Opt-in ID."
  end
  delete ':id' do
    OptIn.find(params[:id]).destroy
  end
end
