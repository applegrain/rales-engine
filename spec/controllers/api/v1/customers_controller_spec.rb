require "rails_helper"

describe Api::V1::CustomersController do
  let(:customer) { Fabricate(:customer) }

  context "#show" do

    it "returns a record matching the given id" do
      get :show, id: customer.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:first_name]).to eq customer.first_name
      expect(json[:last_name]).to eq customer.last_name
    end
  end

  context "#find" do
    it "returns a record matching the given id" do
      get :find, id: customer.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:first_name]).to eq customer.first_name
      expect(json[:last_name]).to eq customer.last_name
    end

    it "returns a record matching the given first name" do
      get :find, first_name: customer.first_name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:first_name]).to eq customer.first_name
      expect(json[:last_name]).to eq customer.last_name
    end

    it "returns a record matching the given last name" do
      get :find, last_name: customer.last_name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:first_name]).to eq customer.first_name
      expect(json[:last_name]).to eq customer.last_name
    end
  end

  context "#find_all" do
    let!(:customer) { Fabricate(:customer) }
    let!(:customer1) { Fabricate(:customer, last_name: "David") }
    let!(:customer2) { Fabricate(:customer, first_name: "Larry") }

    it "returns all records matching the given id" do
      get :find_all, id: customer.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 1
      expect(json.first[:first_name]).to eq customer.first_name
      expect(json.first[:last_name]).to eq customer.last_name
    end

    it "returns all records matching the given first name" do
      get :find_all, first_name: customer.first_name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 2
      expect(json.first[:last_name]).to eq customer.last_name
      expect(json.last[:last_name]).to eq customer1.last_name
    end

    it "returns all records matching the given last name" do
      get :find_all, last_name: customer.last_name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 2
      expect(json.first[:first_name]).to eq customer.first_name
      expect(json.last[:first_name]).to eq customer2.first_name
    end
  end

  context "#invoices" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:invoice) { Fabricate(:invoice,
                               merchant_id: merchant.id,
                               customer_id: customer.id) }

    it "returns invoices for given customer" do
      get :invoices, customer_id: customer.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true).first

      expect(response.code).to eq "200"
      expect(json[:status]).to eq invoice.status
      expect(json[:customer_id]).to eq customer.id
      expect(json[:merchant_id]).to eq merchant.id
    end
  end

  context "#transactions" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:invoice) { Fabricate(:invoice,
                               merchant_id: merchant.id,
                               customer_id: customer.id) }
    let!(:transaction) { Fabricate(:transaction, invoice_id: invoice.id) }

    it "returns transactions for given customer" do
      get :transactions, customer_id: customer.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true).first

      expect(response.code).to eq "200"
      expect(json[:credit_card_number]).to eq transaction.credit_card_number
      expect(json[:invoice_id]).to eq invoice.id
      expect(json[:result]).to eq transaction.result
    end
  end
end
