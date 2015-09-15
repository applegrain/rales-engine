require "rails_helper"

describe Api::V1::InvoiceItemsController do
  let!(:merchant) { Fabricate(:merchant) }
  let!(:customer) { Fabricate(:customer) }
  let!(:item) { Fabricate(:item) }
  let!(:invoice) { Fabricate(:invoice,
                            customer_id: customer.id,
                            merchant_id: merchant.id) }
  let(:invoice_item) { Fabricate(:invoice_item,
                                 item_id: item.id,
                                 invoice_id: invoice.id) }

  context "#show" do

    it "returns a record matching the given id" do
      get :show, id: invoice_item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice_item.id
      expect(json[:item_id]).to eq invoice_item.item_id
      expect(json[:invoice_id]).to eq invoice_item.invoice_id
      expect(json[:unit_price]).to eq invoice_item.unit_price
      expect(json[:quantity]).to eq invoice_item.quantity
    end
  end

  context "#find" do
    it "returns a record matching the given id" do
      get :find, id: invoice_item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice_item.id
      expect(json[:item_id]).to eq invoice_item.item_id
      expect(json[:invoice_id]).to eq invoice_item.invoice_id
      expect(json[:unit_price]).to eq invoice_item.unit_price
      expect(json[:quantity]).to eq invoice_item.quantity
    end

    it "returns a record matching the given item_id" do
      get :find, item_id: invoice_item.item_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice_item.id
      expect(json[:item_id]).to eq invoice_item.item_id
    end

    it "returns a record matching the given invoice_id" do
      get :find, invoice_id: invoice_item.invoice_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice_item.id
      expect(json[:invoice_id]).to eq invoice_item.invoice_id
    end

    it "returns a record matching the given quantity" do
      get :find, quantity: invoice_item.quantity, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice_item.id
      expect(json[:quantity]).to eq invoice_item.quantity
    end

    it "returns a record matching the given unit_price" do
      get :find, unit_price: invoice_item.unit_price, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq invoice_item.id
      expect(json[:unit_price]).to eq invoice_item.unit_price
    end
  end

  context "#find_all" do
    let!(:invoice_item) { Fabricate(:invoice_item,
                                    item_id: item.id,
                                    invoice_id: invoice.id) }
    let!(:invoice_item1) { Fabricate(:invoice_item,
                                     item_id: item.id,
                                     invoice_id: invoice.id) }

    it "returns all records matching the given id" do
      get :find_all, id: invoice_item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq invoice_item.id
    end

    it "returns all records matching the given item_id" do
      get :find_all, item_id: invoice_item.item_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice_item.id
    end

    it "returns all record matching a given invoice_id" do
      get :find_all, invoice_id: invoice_item.invoice_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice_item.id
    end

    it "returns all records matching the given quantity" do
      get :find_all, quantity: invoice_item.quantity, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice_item.id
    end

    it "returns all records matching the given unit_price" do
      get :find_all, unit_price: invoice_item.unit_price, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq invoice_item.id
      expect(json.first[:unit_price]).to eq invoice_item.unit_price
      expect(json.first[:unit_price]).to eq invoice_item1.unit_price
    end
  end
end
