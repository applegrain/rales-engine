require "acceptance_helper"

resource "Customers" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  header "Host", "http://localhost:3000"

  let!(:customer)  { Fabricate(:customer) }
  let!(:customer2) { Fabricate(:customer) }

  context "#index" do
    get "/api/v1/customers" do
      example_request "Returns all customers" do

        expect(status).to eq 200
        expect(response_body).to eq(Customer.all.to_json)
      end
    end
  end

  context "#show" do
    get "/api/v1/customers/:id" do
      let(:id) { customer.id }

      example_request "Returns a specific customer" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json["first_name"]).to eq "Jorge"
        expect(json["last_name"]).to eq "Tellez"
      end
    end
  end

  context "#find" do
    get "/api/v1/customers/find" do
      parameter :id, "id of customer"
      let(:id) { customer.id }

      example_request "Returns the first record matching the given id" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json["id"]).to eq customer.id
      end
    end

    get "/api/v1/customers/find" do
      parameter :first_name, "first name of customer"
      let(:first_name) { customer.first_name }

      example_request "Returns the first record matching the given first name" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json["first_name"]).to eq "Jorge"
      end
    end

    get "/api/v1/customers/find" do
      parameter :last_name, "last name of customer"
      let(:last_name) { customer.last_name }

      example_request "Returns the first record matching the given last name" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json["last_name"]).to eq "Tellez"
      end
    end
  end

  context "#find_all" do
    let!(:customer2) { Fabricate(:customer, last_name: "David") }
    let!(:customer3) { Fabricate(:customer, first_name: "Larry") }

    get "/api/v1/customers/find_all" do
      parameter :id, "id of customer(s)"
      let(:id) { customer.id }

      example_request "Returns all records matching the given id" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json.count).to eq 1
        expect(json.first["id"]).to eq customer.id
      end
    end

    get "/api/v1/customers/find_all" do
      parameter :first_name, "first name of customers"
      let(:first_name) { customer.first_name }

      example_request "Returns all records matching the given first name" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json.count).to eq 2
        expect(json.first["first_name"]).to eq customer.first_name
        expect(json.second["first_name"]).to eq customer2.first_name
      end
    end

    get "/api/v1/customers/find_all" do
      parameter :last_name, "last name of customers"
      let(:last_name) { customer.last_name }

      example_request "Returns all records matching the given last name" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json.count).to eq 2
        expect(json.first["last_name"]).to eq customer.last_name
        expect(json.second["last_name"]).to eq customer3.last_name
      end
    end
  end

  context "#invoices" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:invoice)  { Fabricate(:invoice,
                                merchant_id: merchant.id,
                                customer_id: customer.id) }

    get "/api/v1/customers/:customer_id/invoices" do
      parameter :customer_id, "id of customer"
      let(:customer_id) { customer.id }

      example_request "Returns all invoices matching the given customer" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json.first["status"]).to eq invoice.status
        expect(json.first["customer_id"]).to eq customer.id
        expect(json.first["merchant_id"]).to eq merchant.id
      end
    end
  end

  context "#transactions" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:invoice) { Fabricate(:invoice,
                               merchant_id: merchant.id,
                               customer_id: customer.id) }
    let!(:transaction) { Fabricate(:transaction, invoice_id: invoice.id) }

    get "/api/v1/customers/:customer_id/transactions" do
      parameter :customer_id, "id of customer"
      let(:customer_id) { customer.id }

      example_request "Returns all transactions matching the given customer" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json.first["credit_card_number"]).to eq transaction.credit_card_number
        expect(json.first["invoice_id"]).to eq invoice.id
        expect(json.first["result"]).to eq transaction.result
      end
    end
  end

  context "#favorite_merchant" do
    let!(:merchant) { Fabricate(:merchant) }
    let!(:invoice) { Fabricate(:invoice,
                               merchant_id: merchant.id,
                               customer_id: customer.id) }
    let!(:transaction) { Fabricate(:transaction, invoice_id: invoice.id) }

    get "/api/v1/customers/:customer_id/favorite_merchant" do
      parameter :customer_id, "id of customer"
      let(:customer_id) { customer.id }

      example_request "Returns the favorite merchant of the given customer" do
        json = JSON.parse response_body

        expect(status).to eq 200
        expect(json["id"]).to eq merchant.id
        expect(json["name"]).to eq merchant.name
      end
    end
  end
end
