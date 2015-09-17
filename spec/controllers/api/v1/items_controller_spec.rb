require "rails_helper"

describe Api::V1::ItemsController do
  let!(:merchant) { Fabricate(:merchant) }
  let!(:item) { Fabricate(:item, merchant_id: merchant.id) }
  let!(:invoice) { Fabricate(:invoice) }
  let!(:invoice_item) { Fabricate(:invoice_item,
                                  item_id: item.id,
                                  invoice_id: invoice.id) }

  context "#show" do

    it "returns a record matching the given id" do
      get :show, id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end
  end

  context "#find" do

    it "returns a record matching the given id" do
      get :find, id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end

    it "returns a record matching the given name" do
      get :find, name: item.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end

    it "returns a record matching the given description" do
      get :find, description: item.description, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end
  end

  context "#find_all" do

    let!(:item) { Fabricate(:item, merchant_id: merchant.id) }
    let!(:item1) { Fabricate(:item,
                             merchant_id: merchant.id) }

    it "returns all records matching the given id" do
      get :find_all, id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq item.id
      expect(json.first[:name]).to eq item.name
    end

    it "returns all records matching the given name" do
      get :find_all, name: item.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:name]).to eq item.name
      expect(json.last[:name]).to eq item1.name
    end
  end

  context "#invoice_items" do

    it "returns a collection of all associated invoice items" do
      get :invoice_items, item_id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.first[:id]).to eq invoice_item.id
      expect(json.first[:id]).to eq item.invoice_items.first.id
    end
  end

  context "#merchant" do

    it "returns an assoicated merchant" do
      get :merchant, item_id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq merchant.id
      expect(json[:id]).to eq item.merchant.id
    end
  end

  context "#best_day" do
    let!(:invoice) { Fabricate(:invoice) }
    let!(:transaction) { Fabricate(:transaction,
                                   invoice_id: invoice.id) }
    let!(:invoice_item) { Fabricate(:invoice_item,
                                    invoice_id: invoice.id,
                                    item_id: item.id) }

    it "returns a date on which the item sold the best" do
      get :best_day, item_id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
    end
  end

  context "#merchant" do

    it "returns an assoicated merchant" do
      get :merchant, item_id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq merchant.id
      expect(json[:id]).to eq item.merchant.id
    end
  end
end
