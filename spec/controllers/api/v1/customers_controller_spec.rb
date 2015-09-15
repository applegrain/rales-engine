require "rails_helper"

describe Api::V1::CustomersController do
  context "#show" do
    let(:customer) { Fabricate(:customer) }

    it "returns a record matching the given id" do
      get :show, id: customer.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:first_name]).to eq customer.first_name
      expect(json[:last_name]).to eq customer.last_name
    end
  end

  context "#invoices" do
    let!(:customer) { Fabricate(:customer) }
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
    let!(:customer) { Fabricate(:customer) }
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
