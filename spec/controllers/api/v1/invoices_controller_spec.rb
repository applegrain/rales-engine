require "rails_helper"

describe Api::V1::InvoicesController do
  context "#show" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:customer) { Fabricate(:customer) }
    let(:invoice) { Fabricate(:invoice,
                              customer_id: customer.id,
                              merchant_id: merchant.id) }

    it "returns a record matching the given id" do
      get :show, id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end
  end

  context "#find" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:customer) { Fabricate(:customer) }
    let(:invoice) { Fabricate(:invoice,
                              customer_id: customer.id,
                              merchant_id: merchant.id) }

    it "returns a record matching the given id" do
      get :find, id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end

    it "returns a record matching the given customer_id" do
      get :find, customer_id: invoice.customer_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end

    it "returns a record matching the given merchant_id" do
      get :find, merchant_id: invoice.merchant_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end
  end

  context "#find_all" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:customer) { Fabricate(:customer) }
    let!(:invoice) { Fabricate(:invoice,
                              customer_id: customer.id,
                              merchant_id: merchant.id) }
    let!(:invoice1) { Fabricate(:invoice,
                               customer_id: customer.id,
                               merchant_id: merchant.id) }

    it "returns all records matching a given id" do
      get :find_all, id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq invoice.id
      expect(json.first[:customer_id]).to eq invoice.customer_id
      expect(json.first[:merchant_id]).to eq invoice.merchant_id
    end

    it "returns all records matching the given customer_id" do
      get :find_all, customer_id: invoice.customer_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice.id
    end

    it "returns all records matching the given merchant_id" do
      get :find_all, merchant_id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice.id
    end

    it "returns all records matching the given status" do
      get :find_all, status: invoice.status, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice.id
    end
  end

  context "#transactions" do
    let!(:invoice) { Fabricate(:invoice) }
    let!(:invoice1) { Fabricate(:invoice) }
    let!(:transaction) { Fabricate(:transaction, invoice_id: invoice.id) }

    it "returns all transactions related to an invoice" do
      get :transactions, invoice_id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq transaction.id
    end
  end
end
