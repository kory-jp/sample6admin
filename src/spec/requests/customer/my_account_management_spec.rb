require "rails_helper"

describe "職員による自分のアカウントの管理", "ログイン前" do
  include_examples "a protected singular customer controller", "customer/accounts"
end

describe "職員によるアカウントの管理" do
  before do
    post customer_session_url,
      params: {
        customer_login_form: {
          email: customer.email,
          password: "pw"
        }
      }
  end

  describe "情報表示" do
    let(:customer){create(:customer)}

    example "成功" do
      get customer_account_url
      expect(response.status).to eq(200)
    end

    example "停止フラグがセットされたら強制的にログアウト" do
      customer.update_column(:suspended, true)
      get customer_account_url
      expect(response).to redirect_to(customer_root_url)
    end

    example "セッションタイムアウト" do
      travel_to Customer::Base::TIMEOUT.from_now.advance(seconds: 1)
      get customer_account_url
      expect(response).to redirect_to(customer_login_url)
    end
  end

  describe "更新" do
    let(:customer) { create(:customer) }
    let(:params_hash) { attributes_for(:customer) }

    example "email属性を変更する" do
      params_hash.merge!(email: "test@example.com")
      patch customer_account_url,
        params: {id: customer.id, customer: params_hash}
      customer.reload
      expect(customer.email).to eq("test@example.com")
    end

    example "suspendedフラグの変更不可" do
      params_hash.merge!(suspended: true)
      patch customer_account_url,
        params: {id: customer.id, customer: params_hash}
      customer.reload
      expect(customer).not_to be_suspended
    end

    example "hash_passwordの値は書き換え不可" do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: "x")
      expect{
        patch customer_account_url,
          params: {id: customer.id, customer: params_hash}
      }.not_to change{customer.hashed_password.to_s}
    end

    example "例外ActionController::ParameterMissingが発生" do
      expect { patch customer_account_url, params: {id: customer.id}}.to raise_error(ActionController::ParameterMissing)
    end
  end
end