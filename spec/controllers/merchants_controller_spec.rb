require "rails_helper"

describe Api::V1::MerchantsController do
  context "#show" do
    let(:merchant) { Fabricate(:merchant) }

    it "returns a record matching the given id" do
      get :show, id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:id]).to eq merchant.id
      expect(json[:name]).to eq merchant.name
    end
  end

  context "#find" do
    let(:merchant) { Fabricate(:merchant) }

    it "returns a record matching the given id" do
      get :find, id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:id]).to eq merchant.id
      expect(json[:name]).to eq merchant.name
    end

    it "returns a record matching the given name" do
      get :find, name: merchant.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json[:id]).to eq merchant.id
      expect(json[:name]).to eq merchant.name
    end
  end

  context "#find_all" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:merchant1) { Fabricate(:merchant, name: "Davis' Dolls") }

    it "returns all records matching the given id" do
      get :find_all, id: merchant.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true).first

      expect(response.code).to eq "200"
      expect(json[:id]).to eq merchant.id
      expect(json[:name]).to eq merchant.name
    end

    it "returns all records matching the given name" do
      get :find_all, name: merchant.name, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.code).to eq "200"
      expect(json.count).to eq 2
      expect(json.first[:name]).to eq merchant.name
      expect(json.last[:name]).to eq merchant1.name
    end
  end
end
