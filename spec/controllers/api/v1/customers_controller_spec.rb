require "rails_helper"

describe Api::V1::CustomersController do
  context "#show" do
    before(:each) do
      @customer = Customer.create(first_name: "Lovisa", last_name: "Svallingson")
    end


    it "returns a record matching the given id" do
      get :show, id: @customer.id
      response.should be_success
    end
  end
end


# show

# random

# find by id, first name, last name

# find all by ^
