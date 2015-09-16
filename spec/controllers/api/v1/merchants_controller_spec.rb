require "rails_helper"

describe Api::V1::MerchantsController do
  let(:merchant) { Fabricate(:merchant) }
  let!(:invoice) { Fabricate(:invoice,
                             merchant_id: merchant.id) }
  let!(:invoice_item) { Fabricate(:invoice_item,
                                  invoice_id: invoice.id) }
  let!(:transaction) { Fabricate(:transaction,
                                 invoice_id: invoice.id) }

  context "#show" do

    it "returns a record matching the given id" do
      get :show, id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq merchant.id
      expect(json[:name]).to eq merchant.name
    end
  end

  context "#find" do

    it "returns a record matching the given id" do
      get :find, id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq merchant.id
      expect(json[:name]).to eq merchant.name
    end

    it "returns a record matching the given name" do
      get :find, name: merchant.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq merchant.id
      expect(json[:name]).to eq merchant.name
    end
  end

  context "#find_all" do

    let!(:merchant1) { Fabricate(:merchant, name: "Davis' Dolls") }

    it "returns all records matching the given id" do
      get :find_all, id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq merchant.id
      expect(json.first[:name]).to eq merchant.name
    end

    it "returns all records matching the given name" do
      get :find_all, name: merchant.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:name]).to eq merchant.name
      expect(json.last[:name]).to eq merchant1.name
    end
  end

  context "#items" do

    let!(:merchant1) { Fabricate(:merchant) }
    let!(:item) { Fabricate(:item, merchant_id: merchant.id) }

    it "returns all items for given merchant" do
      get :items, merchant_id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
    end

    it "returns an empty array when the merchant has no items" do
      get :items, merchant_id: merchant1.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 0
    end
  end

  context "#invoices" do

    let!(:merchant1) { Fabricate(:merchant) }
    let!(:invoice) { Fabricate(:invoice, merchant_id: merchant.id) }

    it "returns all invoices for given merchant" do
      get :invoices, merchant_id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
    end

    it "returns an empty array when the merchant has no invoices" do
      get :invoices, merchant_id: merchant1.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 0
    end
  end

  context "#revenue" do

    it "returns total revenue for that merchant across all transactions" do
      get :revenue, merchant_id: merchant.id, format: :json

      expect(response.status).to eq 200
      expect(response.body).to eq "0.2"
    end
  end

  context "#revenue?date=x" do

    it "returns total revenue for that merchant on a given date" do
      get :revenue, merchant_id: merchant.id, date: "2010-01-11 12:12:12", format: :json

      expect(response.status).to eq 200
    end
  end
end


# GET /api/v1/merchants/:id/revenue?date=x returns the total revenue for that merchant for a specific invoice date x
