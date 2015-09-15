require "rails_helper"

describe Api::V1::InvoicesController do
  let!(:merchant) { Fabricate(:merchant) }
  let!(:customer) { Fabricate(:customer) }
  let(:invoice) { Fabricate(:invoice,
                            customer_id: customer.id,
                            merchant_id: merchant.id) }

  context "#show" do
    it "returns a record matching the given id" do
      get :show, id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end
  end

  context "#find" do
    it "returns a record matching the given id" do
      get :find, id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end

    it "returns a record matching the given customer_id" do
      get :find, customer_id: invoice.customer_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end

    it "returns a record matching the given merchant_id" do
      get :find, merchant_id: invoice.merchant_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice.id
      expect(json[:customer_id]).to eq invoice.customer_id
      expect(json[:merchant_id]).to eq invoice.merchant_id
    end
  end

  context "#find_all" do
    let!(:invoice) { Fabricate(:invoice,
                              customer_id: customer.id,
                              merchant_id: merchant.id) }
    let!(:invoice1) { Fabricate(:invoice,
                               customer_id: customer.id,
                               merchant_id: merchant.id) }

    it "returns all records matching a given id" do
      get :find_all, id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq invoice.id
      expect(json.first[:customer_id]).to eq invoice.customer_id
      expect(json.first[:merchant_id]).to eq invoice.merchant_id
    end

    it "returns all records matching the given customer_id" do
      get :find_all, customer_id: invoice.customer_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice.id
    end

    it "returns all records matching the given merchant_id" do
      get :find_all, merchant_id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice.id
    end

    it "returns all records matching the given status" do
      get :find_all, status: invoice.status, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
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

      expect(response.status).to eq 200
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq transaction.id
    end

    it "returns an empty array if there are no related transactions" do
      get :transactions, invoice_id: invoice1.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 0
    end
  end

  context "#invoice_items" do
    let!(:invoice) { Fabricate(:invoice) }
    let!(:invoice1) { Fabricate(:invoice) }
    let!(:invoice_item) { Fabricate(:invoice_item, invoice_id: invoice.id) }

    it "returns all invoice items related to an invoice" do
      get :invoice_items, invoice_id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq invoice_item.id
    end

    it "returns an empty array if there are no related invoice_items" do
      get :invoice_items, invoice_id: invoice1.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 0
    end
  end

  context "#items" do
    let!(:invoice_item) { Fabricate(:invoice_item,
                                    invoice_id: invoice.id,
                                    item_id: item.id) }
    let!(:item) { Fabricate(:item, merchant_id: merchant.id) }

    it "returns a collection of associated items" do
      get :items, invoice_id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.first[:id]).to eq item.id
      expect(json.first[:merchant_id]).to eq merchant.id
    end
  end

  context "#customer" do
    it "returns the associated customer" do
      get :customer, invoice_id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq customer.id
      expect(invoice.id).to eq customer.invoices.first.id
    end
  end

  context "#merchant" do
    it "returns the associated merchant" do
      get :merchant, invoice_id: invoice.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq merchant.id
      expect(invoice.id).to eq merchant.invoices.first.id
    end
  end
end
