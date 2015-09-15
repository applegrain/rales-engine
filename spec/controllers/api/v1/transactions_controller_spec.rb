require "rails_helper"

describe Api::V1::TransactionsController do
  let!(:invoice) { Fabricate(:invoice) }
  let(:transaction) { Fabricate(:transaction, invoice_id: invoice.id) }

  context "#show" do
    it "returns a record matching the given id" do
      get :show, id: transaction.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq transaction.id
      expect(json[:credit_card_number]).to eq transaction.credit_card_number
      expect(json[:result]).to eq transaction.result
      expect(json[:result]).to eq transaction.result
      expect(json[:invoice_id]).to eq transaction.invoice_id
    end
  end

  context "#find" do
    it "returns a record matching the given id" do
      get :find, id: transaction.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq transaction.id
    end

    it "returns a record matching the given credit_card_number" do
      get :find, credit_card_number: transaction.credit_card_number, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq transaction.id
    end

    it "returns a record matching the given result" do
      get :find, result: transaction.result, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq transaction.id
    end

    it "returns a record matching the given invoice id" do
      get :find, invoice_id: transaction.invoice_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json[:id]).to eq transaction.id
    end
  end

  context "#find_all" do
    let!(:invoice) { Fabricate(:invoice) }
    let!(:transaction) { Fabricate(:transaction, invoice_id: invoice.id) }
    let!(:transaction1) { Fabricate(:transaction, invoice_id: invoice.id) }

    it "returns all records matching the given id" do
      get :find_all, id: transaction.id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 1
      expect(json.first[:id]).to eq transaction.id
      expect(json.first[:result]).to eq transaction.result
    end

    it "returns all records matching the given credit card numbers" do
      get :find_all, credit_card_number: transaction.credit_card_number, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq transaction.id
      expect(json.last[:credit_card_number]).to eq transaction1.credit_card_number
    end

    it "returns all records matching the given result" do
      get :find_all, result: transaction.result, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq transaction.id
      expect(json.last[:result]).to eq transaction1.result
    end

    it "returns all records matching the given invoice_id" do
      get :find_all, invoice_id: transaction.invoice_id, format: :json

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq 200
      expect(json.count).to eq 2
      expect(json.first[:id]).to eq transaction.id
      expect(json.last[:invoice_id]).to eq transaction1.invoice_id
    end
  end
end
