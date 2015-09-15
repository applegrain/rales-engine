require "rails_helper"

describe Api::V1::ItemsController do
  context "#show" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:item) { Fabricate(:item, merchant_id: merchant.id) }

    it "returns a record matching the given id" do
      get :show, id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end
  end

  context "#find" do
    let(:merchant) { Fabricate(:merchant) }
    let!(:item) { Fabricate(:item, merchant_id: merchant.id) }

    it "returns a record matching the given id" do
      get :find, id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end

    it "returns a record matching the given name" do
      get :find, name: item.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end

    it "returns a record matching the given description" do
      get :find, description: item.description, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:name]).to eq item.name
      expect(json[:description]).to eq item.description
      expect(json[:merchant_id]).to eq merchant.id
    end
  end

  context "#find_all" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:item) { Fabricate(:item, merchant_id: merchant.id) }
    let!(:item1) { Fabricate(:item,
                             merchant_id: merchant.id) }

    it "returns all records matching the given id" do
      get :find_all, id: item.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq item.id
      expect(json.first[:name]).to eq item.name
    end

    it "returns all records matching the given name" do
      get :find_all, name: item.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 2
      expect(json.first[:name]).to eq item.name
      expect(json.last[:name]).to eq item1.name
    end
  end
end
