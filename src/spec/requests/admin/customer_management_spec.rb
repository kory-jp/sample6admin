require "rails_helper"

describe "管理者による職員管理", "ログイン前" do
  include_examples  "a protected admin controller", "admin/customers"
end

describe "管理者による職員管理" do
  let(:administrator){create(:administrator)}

  before do
    post admin_session_url,
      params: {
        admin_login_form: {
          email: administrator.email,
          password: "pw"
        }
      }
  end

  describe "一覧" do
    example "成功" do
      get admin_customers_url
      expect(response.status).to eq(200)
    end

    example "停止フラグがセットされたら強制的にログアウト" do
      administrator.update_column(:suspended, true)
      get admin_customers_url
      expect(response).to redirect_to(admin_root_url)
    end

    example "セッションタイムアウト" do
      travel_to Admin::Base::TIMEOUT.from_now.advance(seconds: 1)
      get admin_customers_url
      expect(response).to redirect_to(admin_login_url)
    end
  end

  describe "新規登録" do
    let(:params_hash){attributes_for(:customer)}

    example "職員一覧ページにリダイレクト" do
      post admin_customers_url, params: {customer: params_hash}
      expect(response).to redirect_to(admin_customers_url)
    end

    example "メールアドレスが空白の場合は登録失敗" do
      params_hash.merge!(email: "" )
      post admin_customers_url, params: {customer: params_hash}
      # admin/customer_contollerのnewアクションの失敗のケースの処理を記載
      expect(response).not_to redirect_to(new_admin_customer_url)
    end 

    example "例外ActionController::ParameterMissingが発生" do
      expect {post admin_customers_url}.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe "更新" do
    let(:customer){create(:customer)}
    let(:params_hash){attributes_for(:customer)}

    example "suspendedフラグをセットする" do
      params_hash.merge!(suspended: true)
      patch admin_customer_url(customer),
        params: {customer: params_hash}
      customer.reload
      expect(customer).to be_suspended
    end

    example "hash_passwordの値は書き換え不可" do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: "x")
      expect{
        patch admin_customer_url(customer),
          params: {customer: params_hash}
      }.not_to change{customer.hashed_password.to_s}
    end
  end
end