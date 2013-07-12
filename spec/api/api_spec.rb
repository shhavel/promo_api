require 'spec_helper'

describe API do
  include Rack::Test::Methods

  def app
    API
  end

  before(:each) do
    ActiveRecord::Base.connection.execute "TRUNCATE #{OptIn.table_name}"
    @opt_in1 = OptIn.create(email: 'evgenij@test.com', permission_type: 'permanent', channel: 'email', company_name: 'milk&cookies')
    @opt_in2 = OptIn.create(email: 'ivan.kaljuzhin@gmail.com', permission_type: 'one-time', channel: 'email', company_name: 'SPAM Delivery')
  end

  specify 'GET /opt_ins' do
    get "/opt_ins"
    last_response.should be_ok
    JSON.parse(last_response.body).should have(2).records
  end

  specify 'GET /opt_ins/:id' do
    get "/opt_ins/#{@opt_in2.id}"
    last_response.should be_ok
    JSON.parse(last_response.body)["opt_in"]["email"].should == "ivan.kaljuzhin@gmail.com"
  end

  describe 'POST /opt_ins' do
    it "creates opt-in" do
      post "/opt_ins", { 'email' => 'petr@test.com', 'permission_type' => 'permanent', 'channel' => 'email', 'company_name' => 'milk&cookies' }
      last_response.status.should == 201
      JSON.parse(last_response.body)['opt_in']['email'].should == 'petr@test.com'
      OptIn.should have(3).records
    end

    it "requires email parameter" do
      post "/opt_ins", {}
      last_response.status.should == 400
      JSON.parse(last_response.body)['error'].should == "missing parameter: email"
    end
  end

  specify 'PUT /opt_ins/:id' do
    put "/opt_ins/#{@opt_in2.id}", { 'channel' => 'sms+email' }
    last_response.should be_ok
    OptIn.find(@opt_in2.id).channel.should == 'sms+email'
  end

  specify 'DELETE /opt_ins/:id' do
    delete "/opt_ins/#{@opt_in1.id}"
    last_response.should be_ok
    JSON.parse(last_response.body)["opt_in"]["email"].should == "evgenij@test.com"
    OptIn.should have(1).record
  end
end
